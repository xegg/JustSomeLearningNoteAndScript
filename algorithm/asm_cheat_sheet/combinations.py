# COOL
def combinations(iterable, r):
    pool = tuple(iterable)
    n = len(pool)
    if r > n:
        return
    indices = range(r)
    print indices
    yield tuple(pool[i] for i in indices)
    while True:
        for i in reversed(range(r)):
            print indices[i], i+n-r
            if indices[i] != i + n - r:
                break
        else:
            return
        indices[i] += 1
        print indices, 'a'
        for j in range(i+1, r):
            indices[j] = indices[j-1] + 1
            print indice, 'b'
        yield tuple(pool[i] for i in indices)


for i in  combinations([1,2,3], 2):
    print i
