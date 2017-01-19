import Database.HDBC
import Database.HDBC.Sqlite3 (connectSqlite3)

{- | 定义一个函数，它接受一个表示要获取的最大 id 值作为参数。
函数会从 test 数据库里面获取所有匹配的行，并以一种美观的方式将它们打印到屏幕上面。 -}
query :: Int -> IO ()
query maxId =
    do -- 连接数据库
        conn <- connectSqlite3 "test1.db"

        -- 执行查询并将结果储存在 r 里面
        r <- quickQuery' conn
            "SELECT id, desc from test where id <= ? ORDER BY id, desc"
            [toSql maxId]

        -- 将每个行转换为 String
        let stringRows = map convRow r

        -- 打印行
        mapM_ putStrLn stringRows

        -- 断开与服务器之间的连接
        disconnect conn

    where convRow :: [SqlValue] -> String
        convRow [sqlId, sqlDesc] =
            show intid ++ ": " ++ desc
            where intid = (fromSql sqlId)::Integer
                desc = case fromSql sqlDesc of
                            Just x -> x
                            Nothing -> "NULL"
        convRow x = fail $ "Unexpected result: " ++ show x
