import Data.List (nub, sort)
import Data.List hiding (nub)
import qualified Data.Map 
import qualified Data.Map as M

{-http://www.haskell.org/hoogle/-}

intersperse '.' "MONKEY"
intersperse 0 [1, 2, 3, 4]

intercalate " " [[0,0,0],[1,2,3]]

map sum $ transpose [[0, 3, 5, 9], [10, 0, 0, 9], [8, 5, 1, -1]]

concat ["foo", "bar", "car"]
concatMap (replicate 4) [1..3]

take 10 $ iterate (*2) 1
take 3 $ iterate (++ "haha") "haha"

splitAt 3 "heyman"
let (a, b) = splitAt 3 "foobar" in b ++ a

break (==4) [1,2,3,4]
span (/=4) [1,2,3,4,5]

sort [1,2,3]

group [1,1,2,2,3]

inits "woot"
["", "w", "wo", "woo", "woot"]
tails "woot"
["woot", "oot", "ot", "t", ""]

map (\l@(x:xs) -> (x, length l)) . group . sort $ [1,2,2,3,]

search :: (Eq a) => [a] -> [a] -> Bool
search needle haystack = 
  let nlen = length needle
  in foldl (\acc x -> if take nlen x == needle Then True else acc) False (tails haystack)

isInfixOf "cat" "im a cat burglar"
isPrefixOf "Hey" "hey there!"
isSuffixOf "there!" "oh hey there!"

partition (>3) [1,2,3, 5]

may a
elemIndex
elemIndices

zipWith2,zipWith3..zipWith7
lines "first line\n second line\n thrid line"
unlines 
words unwords

delete 'h' 'hey there string'
[1..10] \\ [2, 5, 9]
union 'hey man' 'man what's up'
intersect

groupBy (\x y -> (x > 0) == (y > 0)) values

on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
f `on` g = \x y -> f (g x) (g y)

filter (not . any isSpace) . groupBy ((==) `on` isSpace) $ "hey guy its my"

map ord "abcdefgh"

encode shift msg = 
  let ords = map ord msg
    shifted = map (+ shift) ords
  in map chr shifted

decode shift msg = encode (negate shift) msg

findKey :: (Eq k) => k -> [(k, v) -> Maybe v]
findKey key = foldr (\(r, v) acc -> if key == k then Just v else acc) Nothing

Map.insert 3 100 Map.empty

fromList' :: (Ord k) => [(k, v)] -> Map.Map k v
fromList' = forldr (\(k, v) acc -> Map.insert k v acc) Map.empty

Map.null
Map.size
Map.singleton

module Geometry
( sphereVolume
, sphereArea
, cubeVolume
, cubeArea
, cuboidArea
, cuboidVolume
) where
