class Number:
    def __init__(self, x: int) -> None:
        self.x = x
        self.minus = lambda y: self.x - y # we'll come back to this

    def plus(self, y: int) -> int:
            return self.x + y

one = Number(1)

print(one.plus(2))
print(Number.plus(one, 2))

Number.times = lambda self, y: self.x * y
print(one.times(2))

def _divide(self, y):
    try:
        return self.x / y
    except ZeroDivisionError:
        print("Tried to divide {} by 0".format(self.x))
        def __newdivide(self, y):
            print("{} / {}".format(self.x, y))
            return _divide(self, y)
        self.__class__.divide = __newdivide
Number.divide = _divide

# https://medium.com/@hwayne/stupid-python-tricks-abusing-explicit-self-53d46b72e9e0#.ohnfhfdu0
