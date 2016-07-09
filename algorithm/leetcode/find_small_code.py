#!/usr/bin/env python
import os
from pprint import pprint


files = {}
for fs in os.walk('.'):
    for f in fs[2]:
        if f:
            lines = 0
            for line in open(fs[0]+'/'+f):
                if not any(map(line.strip().startswith, ['\n','//', '*', '/*'])):
                    lines += 1
            files[f] = lines

b = files.items()
b.sort(key=lambda x: x[1])
pprint(b)

# lines = 0
# for line in open('/home/egg/Learn/Article/algorithms/cpp_back/wordSearch'+'/'+'wordSearch.cpp'):
    # if not any(map(line.strip().startswith, ['//', '*', '/*'])):
        # lines += 1
# print lines
# files[f] = lines
