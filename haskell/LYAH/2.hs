succ 8
++ 会遍历整个列表, :只会追加到列表

head [5,4,3,2]
tail [5,4,3,2]
last [5,4,3,2]
init [5,4,3,2]

小心空指针

length [5,4,3,2]
null 判断是否为空
reverse 反转字符串
take n [a]
max 返回数字
maximum 返回列表最大
sum product 
elem返回是否当前列表的元素
(1, 3..20)
repeat
cycle
take 10 (repeat 4)
replicate 4 10
rightTriangle = [(a,b,c) | c <- [1..10], b <- [1..c], a <-[1..b], a^2 + b^2 == c^2]
