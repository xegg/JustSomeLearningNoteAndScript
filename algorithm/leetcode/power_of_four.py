def is_power_of_four(n):
    if n and not (n & (n - 1)):
        while (n > 1):
            n >>= 1
            count +=1
        return 1 if count % 2 == 0 else 0
    return 0
print is_power_of_four(64)
