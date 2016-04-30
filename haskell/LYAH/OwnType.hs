data Bool = False | True
data Shape = Circle Float Float Float | Rectange Float Float Float Float

surface :: Shape -> Float
surface (circle _ _ r) = pi * r ^ 2
surface (Rectange x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)

data Shape = Circle Float Float Float | Rectange Float Float Float Float deriving (Show)

data Point = Point Float Float deriving (Show)
data Shape = Circle Point Float | Rectange Point Point deriving (Show)

module Shape 
( Point(..)
，Shape(..)
, surface
, nudge
, baseCircle
) where

data Person = Person String String Int Float String String deriving (show)

firstName :: Person -> String
firstName (Person firstname _ _ _ _ _) = firstname

data Car = Car {company :: String, model :: String, year :: Int} deriving (Show)
Car {company="Ford", model="Mustang", year=1967}

data Maybe a = Nothing | Just a

class Eq a where
  (==) :: a -> a-> Bool
  (/=) :: a -> a-> Bool
  x == y  = not (x /= y)
  x \= y  = not (x == y)
