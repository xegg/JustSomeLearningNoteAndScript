main f action = do 
    result <- action
    return (f result)

main do line <- fmap reverse getLine
        putStrLn $ "You said " ++ line ++ " backwards!"
        putStrLn $ "Yes, you really said" ++ line ++ " backwards!"

import Data.Char
import Data.List
main = do line <- fmap (intersperse '-' . reverse . map toUpper) getLine
          putStrLn line

import Control.Applicative
import Data.Monoid
import qualified Data.Foldable as F

data CMaybe a = CNothing | CJust Int a deriving (Show)

instance Functor CMaybe where
    fmap f CNothing = CNothing
    fmap f (CJust counter x) = CJust (counter + 1) (f x)

sequenceA :: (Applicative f) => [f a] -> f[a]
sequenceA = foldr (liftA2 (:)) (pure [])

newtype CharList = CharList { getCharList :: [Char] } deriving(Eq, Show)

newType Pair b a = Pair {getPair :: (a, b)}
instance Functor (Pair c) where 
    fmap f (Pair (x, y)) = Pair (f x, y)

newtype CoolBool = CoolBool { getCoolBool :: Bool }

helloMe :: CoolBool -> String
helloMe (CoolBool _) = "hello"
