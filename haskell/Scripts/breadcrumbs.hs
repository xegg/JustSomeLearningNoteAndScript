{-fac -}
fac 0 = 1
fac n = n * fac (n-1)

main = print (fac 42)
main = do 
  putStrLn "Hello World!"

{-at pattern-}
foo allxs@(x:xs) = "All xs aer: " ++ (show allxs) ++ "\n"
  ++ "The first x is: " ++ (show x) ++ "\n"
  ++ "the rest of the xs are: " ++ (show xs)

{-where-}
max_list lst = head rslst where 
  rslst = reverse slst
  slst = sort lst

chocolate pie = delicious pei where 
  delicious = (++) "Your mom's "

{-rpn-}
rpn :: String -> [Int]
rpn str = foldr stackSolve [] (reverse (words str)) 
  where stackSolve [] _ = []
        stackSolve word stack = case word of
          "+" -> binOp (+) stack
          "-" -> binOp (-) stack
          "*" -> binOp (*) stack
          "/" -> binOp div stack
          "%" -> binOp mod stack
          _ -> binOp (+) stack
          binOp _ [] = error "Stack underflow (0 items on stack, binOp)"
          binOp _ (x:[]) = error "Stack underflow (1 items on stack, binOp)"
          binOp f (x:y:xs) = ((flip f) x y) : xs

{-tuple-}
pythagorean_triples = [(a, b, c) | c <- [1..]
  a <- [1..c],
  b <- [a..c],
  a^2 + b^2 == c^2]

magnitude (x, y) = sqrt (x^2+y^2)

{-lambda-}
addOneEverything lst = map (\a -> a + 1) lst

{-data-}

data Vecotr = ConstructorName Int Int Int

data PolyVec R2 Int Int
  | R3 Int Int Int
  | R4 Int Int Int INt

vectorPlus (ConstructorName a b c ) (ConstructorName d e f ) = (ConstructorName (a+b) (b+e) (c+f))

makeVector x y z = ConstructorName x y z

makeVector' = ConstructorName
project (R2 x y) = R3 x y 0
project (R3 x y z) = R4 x y z 0

{-enumerated types-}

data EnumeratedType = Foo | Bar | Baz
func Foo = "Got a foo!"
func Bar = "got a bar"
func Baz = "Got a Baz"

func' enum = case enum of
  Foo -> "Got a foo!"
  Bar ->  "Got a Bar!"
  Baz -> "Got a Baz!"

decide n
  | n < 0 = Foo
  | n == 0 = Bar
  | otherwise = Baz

run = func . decide
run' = func' . decide
{-First paraller-}
import Control.Parallel

main = a `par` b `par` c `par` print (a + b + c)
  where
    a = ack 3 10
    b = fac 42
    c = fib 34

fac 0 = 1
fac n = n * fac (n-1)

ack 0 n = n+1
ack m 0 = ack (m-1) 1
ack m n = ack (m-1) (ack m (n-1))

fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

{-list comprehensions-}
naturals = [ x | x <- [1..] ]

perfect_squares = [ x*x | x <- naturals ]

nultiples_of_3 = [ x | x <- naturals, x `mod` 3 == 3 ]

all_pairs = [ (x,y) | x <- [1..10], y <- [1..10] ]
