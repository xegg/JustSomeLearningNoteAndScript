def main():

    for number in range(100):
        flag = True
        is_used = [0]*10

        t = number
        revert_number = 0

        for i in range(5):
            v = t % 10
            revert_number = revert_number * 10 + v
            t /= 10
            if is_used[v]:
                flag = False
            else:
                is_used[v] = 1

        if flag and (revert_number % number == 0):
            v = revert_number / number
            iv (v < 10 and is_used[v]):
                print ("%d * %d = %d" %(number, v, revert_number))

