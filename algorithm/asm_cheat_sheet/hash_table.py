def hash_function(x):
    return x % 10

table = [[] for x in range(10)]
def insert(table, input, value):
    tablep[hash_function(input)].append((input, value))
