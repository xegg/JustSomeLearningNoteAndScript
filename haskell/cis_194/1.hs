toDigits :: Integer -> [Integer]
toDigits 0 = []
toDigits n = toDigits (n `div` 10) ++ [n `mod` 10]

toDigitsRev :: Integer -> [Integer]
toDigitsRev 0 = []
toDigitsRev n = reverse (toDigits n)

doubleVeryOther :: [Integer] -> [Integer]
doubleVeryOther [] = []
doubleVeryOther [x] = [x]
doubleVeryOther (x:y:ys) = x : (y*2) : doubleVeryOther ys

sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits [x] = sum (toDigits x)
sumDigits (x:xs) = (sum (toDigits x)) + (sumDigits xs)

validate :: Integer -> Bool
validate 0 = False
validate 32 = True
validate n = False
{-validate n = (sumDigits ( doubleVeryOther (toDigits n))) `mod` 10 == 0 -}

type Peg = String
type Move = (Peg, Peg)

hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
{-hanoi n a b c = (a, c) : (a, b) : (c,b) : hanoi (n-1) b,c -}
hanoi n a b c 
    | n == 0 = []
    | n == 1 = (a, b) : hanoi 0 a b c 
    | otherwise = hanoi (n-1) a c b ++ [(a, b)] ++ hanoi (n-1) c b a

{-hanoi' :: Integer -> Peg -> Peg -> Peg -> [Move]-}
{-hanoi' n a b c d-}
    {-| n == 0 = []-}
    {-| n == 1 = (a,b) : hanoi 0 a b c d -}
    {-| n == 2 = (a,b) : (a,c) : (b, c)-}

{-hanoi4 :: Integer -> Peg -> Peg -> Peg -> Peg -> [Move]-}
