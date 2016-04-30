zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = g
    where g x y = f y x

flip' zip [1, 2, 3, 4, 5] "hello"

map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x: map f xs

filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
filter p (x:xs)
    | p x = x: filter p xs:

largestDivisible :: (Integral a) => a
largestDivisible = head (filter p [1000000, 999999..])
      where p x = x `mod` 3829 == 0

sum (takeWhile (<1000) (filter odd (map (^2) [1..])))
sum (takeWhile (<10000) [m | m <- [n^2 | n <- [1..], odd m]])

chain :: (Integral a) => a -> [a]
chain 1 = [1]
chian n
  | even n = n:chain (n `div` 2)
  | odd n = n:chain (n*3 + 1)

numLongChains :: Int
numLongChains = length (filter isLong (map chain [1..100]))
  where isLong xs = length xs > 15

sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs

elem' :: (Eq a) => a -> [a] -> Bool
elem' y ys = foldl (\acc x -> if x == y then True else acc) False ys

maximum' :: (Ord a) => [a] -> a
maximum' = foldr (\x acc -> if x > acc then x else acc)

reverse' :: [a] -> [a]
reverse' = fold (\acc x -> x : acc) []

product' :: (Num a) => [a] -> a
product' = foldr1(*)

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\x acc -> if p x then x : acc else acc) []

head' = foldr1 (\x _ -> x)

last' = foldl1 (\_ x-> x)

sqrtSums = length (takeWhile (<1000) (scanl (+) (map sqrt [1..]))) + 1

sum (filter (> 10) (map (*2) [2..10]))
sum $ filter (> 10) $ map (*2) [2..10]

map ($ 3) [(4+), (10*), (^2), sqrt]

(.) :: (b -> c) -> (a -> b) -> a -> c
f . g = f (g x)

map (\x -> negate (abs x)) [4, 3, 4]
map (negate . abs) [4, 3, 4]

sum' xs = foldl (+) 0 xs
sum' = fold (+) 0

fn x = ceiling (negate (tan (cos (max 50 x))))
fn = ceiling . negate . tan .cos . max 50

oddSquareSum :: Integer
oddSquareSum = sum . takeWhile (<10000) . filter odd . map (^2) $ [1..]

oddSquareSum :: Integer
oddSquareSum = 
  let oddSquare = filter odd $ map (^2) [1..]
      belowLimit = takeWhile (<10000) oddSquare
  in sum belowLimit

