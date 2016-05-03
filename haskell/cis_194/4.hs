sieveSundaram :: Integer -> [Integer]
sieveSundaram n = map ((+2) . (*2)) $ [1..n] \\ sieve
  where sieve = map (\(i, j) -> i + j + 2*i*j)
                . filter (\(i, j) -> i + j + 2*i*j <= n)
                $ cartProd [1..n] [1..n]

-- Return all possible pairs
cartProd :: [a] -> [b] -> [(a, b)]
cartProd xs ys = [(x,y) | x <- xs, y <- ys]

xor :: [Bool] -> Bool
xor = foldr xor2 False

xor2 :: Bool -> Bool -> Bool
xor2 a b = (a || b) && not (a && b)

map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x y -> f x : y) []

-- foldl with foldr
myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f x = foldr (flip f) x . reverse

fun1' :: [Integer] -> Integer
fun1' = product . map (subtract 2) . filter even

fun2 :: Integer -> Integer
fun2 1 = 0
fun2 n | even n    = n + fun2 (n `div` 2)
       | otherwise = fun2 (3 * n + 1)

fun2' :: Integer -> Integer
fun2' = sum
      . filter even
      . takeWhile (/= 1)
      . iterate (\n -> if even n then n `div` 2 else 3*n+1)

data Tree a = Leaf
            | Node Integer (Tree a) a (Tree a)
  deriving (Show, Eq)

-- should produce a balanced Tree using @foldr@
foldTree :: Eq a => [a] -> Tree a
foldTree xs = foldr (balancedInsert start) Leaf xs
  where start = floor (logBase 2 $ fromIntegral(length xs)::Double)

balancedInsert :: Int -> a -> Tree a -> Tree a
balancedInsert _ _ _ = Leaf
balancedInsert _ x (Node n left y right)
          | right == Leaf = Node n left y (Node (n-1) Leaf x Leaf)
          | otherwise = Node n (Node (n-1) Leaf x Leaf) y right
balancedInsert start x _ = Node  Leaf x Leaf
