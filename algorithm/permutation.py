#difficult understand
def all_perms(str):
    if len(str) <=1:
        print str
        yield str
    else:
        for perm in all_perms(str[1:]):
            print 'hello', perm
            for i in range(len(perm)+1):
                print 'fsdf', i
                print  perm[:i] + str[0:1] + perm[i:]
                # nb str[0:1] works in both string and list contexts
                yield perm[:i] + str[0:1] + perm[i:]

test_list = [1,2,3]
print list(all_perms(test_list))
