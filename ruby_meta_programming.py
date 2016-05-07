# ...
for i in range(3):
    class C:
        print "hello"

# 在python class不是作用域, 但是在ruby中是
class D:
    def x(self):
        print 'x'


class D:
    def y(self):
        print 'y'

obj = D()
# obj.x()
obj.y()

class A():
    pass

def hello():
    print 'hello'

def world(cls):
    print world
# Add unbound method
A.hello = hello
A.world = classmethod(world)

#only for instanse
a = A()
a.hello = types.MethodType(hello, a)

### 打开类技术
