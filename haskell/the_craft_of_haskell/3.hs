module Chapter3 where
import Data.Char


exOr :: Bool -> Bool -> Bool
exOr x y = (x || y) && not (x && y)

myExOr :: Bool -> Bool -> Bool
myExOr True False = True
myExOr False True = True
myExOr _ _ = False

threeDifferent :: Int -> Int -> Int -> Bool
threeDifferent a b c = not (a == b) && not (b == c)

toUpper' ch = chr (ord ch + offset)

toUpper'' ch = if ord ch < ord 'A' then ch else toUpper' ch

offset = ord 'A' - ord 'a'

charToNum' :: Char -> Int
charToNum' ch = if (isDigit ch) then (ord ch - ord '0') else  0

averateThree a b c = sum [a, b, c] / 3

howManyAboveAverate a b c = length $ filter (== True) (map (>(averateThree a b c)) [a,b,c])

{- TODO 求根的习题没有做-}
funny x = x + x
peculiar y = y


