import Prelude hiding (Word)
import Data.Char (toLower)
import Data.List (sort,words)
import System.Environment (getArgs)

type Word  = [Char]
type Key   = [Char]

anagrams :: Int -> [Word] -> String
anagrams n = showResult . groupByKey . sort .
             map addKey . getWords n

getWords :: Int -> [Word] -> [Word]
getWords n = filter ((==n) . length)

addKey :: Word -> (Key,Word)
addKey w = (sort w,w)

groupByKey :: [(Key,Word)] -> [(Key,[Word])]
groupByKey [] = []
groupByKey (kw:kws) = insert kw (groupByKey kws)
 where
 insert (k,w) []            = [(k,[w])]
 insert (k,w) ((k',ws):kws) = if k==k' then (k,w:ws):kws
                              else (k,[w]):(k',ws):kws

showResult :: [(Key,[Word])] -> String
showResult = concat . map showLine
 where
 showLine (k,ws) = k ++ ": " ++ addcommas ws ++ "\n"

addcommas :: [Word] -> String
addcommas []     = []
addcommas [w]    = w
addcommas (w:ws) = w ++ "," ++ addcommas ws

main :: IO ()
main = do {[n] <- getArgs;
           text <- getContents;
           putStr (anagrams (read n) (words text)) }
