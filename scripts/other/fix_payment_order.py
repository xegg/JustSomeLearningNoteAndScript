def un300():
    """ 修复代理的数据 """
    sql = """
    SELECT  client_id, merchant_name, log_time ,log_date, game_id, price
    from ncmj_room_card_sell_log WHERE sell_type=0
    and price !=0
    and log_time >= '2017-02-05 05:18:17.944903' and log_time<='2017-02-10 21:56:11.875205'
    and merchant_name = '官方' order by log_time desc
    """
    objs = core_qpdb.query(sql)
    correct = 0
    null = 0
    over = 0
    for i in objs:
        sql = """
        SELECT  * from room_card_payment_log
        WHERE order_status=1 and  log_time >= %s::timestamp - interval '50 seconds'
        and log_time <=%s and price=%s and user_id=-1 and log_date=%s
        and game_id = %s
        """
        tmp = core_qpdb.query(sql, i['log_time'], i['log_time'], int(i['price']*100), i['log_date'], i['game_id'])
        if len(tmp) == 1:
            sql = """
            update room_card_payment_log set user_id=%s WHERE id =%s;
            """
            # core_qpdb.execute(sql,  i['client_id'], tmp[0]['id'])
            print(sql % (i['client_id'], tmp[0]['id']))
            correct+=1
        elif len(tmp) == 0:
            null += 1
        else:
            over += 1
    print('correct: %s, null: %s, over: %s' %(correct, null, over))
    print(i['log_time'])

def un302():
    """修复用户的顶戴数据"""
    sql = """
    select user_id, log_time, log_time, game_id, log_date, count from user_addroomcard_log
    where isfree=0 and agent_id=0 and count in (10, 20, 50, 100)
    and log_time >= '2017-02-05 05:18:17.944903' and log_time<='2017-02-28 15:37:35.743610'
    order by log_time desc
    """
    objs = log_qpdb.query(sql)
    correct = 0
    null = 0
    over = 0
    for i in objs:
        sql = """
        SELECT  * from room_card_payment_log
        WHERE order_status=1 and  log_time >= %s::timestamp - interval '10800 seconds'
        and log_time <=%s and room_card_num = %s and user_id=-1 and log_date=%s
        and game_id = %s
        """
        tmp = core_qpdb.query(sql, i['log_time'], i['log_time'], i['count'], i['log_date'], i['game_id'])
        if len(tmp) == 1:
            sql = """
            update room_card_payment_log set user_id=%s WHERE id =%s;
            """
            # core_qpdb.execute(sql,  i['user_id'], tmp[0]['id'])
            print(sql % (i['user_id'], tmp[0]['id']))
            correct+=1
        elif len(tmp) == 0:
            null += 1
        else:
            over += 1
    print('correct: %s, null: %s, over: %s' %(correct, null, over))
    print(i['log_time'])

def un301():
    """ 从老的数据库同步数据"""
    data = pd.read_csv("ttt.csv")
    for i, row in data.iterrows():
        print(row['user_id'], row['order_id'])
        sql = """
        update room_card_payment_log set user_id=%s WHERE order_id ='%s' and log_date='%s';
        """
        sql = sql % (row['user_id'], row['order_id'], row['log_date'])
        core_qpdb.execute(sql)

