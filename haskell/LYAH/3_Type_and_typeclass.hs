(Eq a) => a ->a -> Bool
(Eq a) 为型别约束, 告诉a必须又等于操作.

read "5" 
read "[1,2,3,4]"
read "True"
会报错, 因为不知道需要转换成什么型别

Enum 为连续的类型, 可以用succ和pred得到前继子和后继子
Num 可以进行这样的运算(5 ) * (5 :: Integer)

removeNonUppercase :: String -> String
removeNonUppercase s = [c | c <- s, elem c ['A'..'Z']]

addThree:: Int -> Int -> Int -> Int
addThree x y z = x + y + z

factorial :: Integer -> Integer
factorial n = product [1..n]

circumference :: Float -> Float
circumference r = 2 * pi * r

circumference' :: Double -> Double
circumference' r = 2 * pi * r
