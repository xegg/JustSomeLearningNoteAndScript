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

doubleMe x = x + x
doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100
                      then x
                      else x * 2
doubleSmallNumber' x = (if x > 100 then x else x * 2) + 1

conanO'Brien = "It's a-me, Conan O'Brien!"

boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

nouns = ["hobo","frog","pope"]
adjectives = ["lazy","grouchy","scheming"]
funPhrases = [adj ++ " " ++ noun | adj <- adjectives, noun <- nouns]

length' xs = sum [1 | _ <- xs]

removeNonUppercase s = [c | c <- s, elem c ['A'..'Z']]

rightTriangle = [(a,b,c) | c <- [1..10], b <- [1..c], a <-[1..b], a^2 + b^2 == c^2]
