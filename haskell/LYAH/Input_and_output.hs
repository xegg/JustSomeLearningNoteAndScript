main = putStrLn "hello, world"

main = do
    putStrLn "Hello, what's your name"
    name <- getLine 
    putStrLn ("Hey " ++ name ++ ", you rock!")

main = do 
    putStrLn "What's your first name?"
    firstName -< getLine
    putStrLn "What's your last name"
    lastNmae -< getLIne 
    let bigFirstName = map toUpper firstName
        bigLastName = map toUpper lastName 
    putStrLn $ "hey " ++ bigFirstName ++ " " ++ bigLastName ++ ", how are you?"

import Contrl.Monad

main = do 
    c <- getChar 
    when (c /= ' ') $ do 
        putChar c
        main

main = do 
    a <- getLine
    b <- getLine 
    c <- getLine 
    print [a, b, c]

main = do 
    rs <- sequence [getLine, getLine, getLine]
    print rs

main = forever $ do 
    putStr "Give me some input: "
    l <- getLine 
    putStrLn $ map toUpper l

main = do 
    colors <- forM [1, 2, 3, 4] (\a -> do 
        putStrnLn $ "which color do you associate with the number " ++ show a ++ "?"
        color <- getLine 
        return color)
    putStrLn "The colors that you associate with 1, 2, 3 and 4 are: "
    mapM putStrLn colors

main = interact $ unlines . filter ((<10) . length) . lines

respondPalindromes = unlines . map (\xs -> 
    if isPalindRome xs then "palindrome" else " not a palindrome") . lines
        where isPalindRome xs = xs == reverse xs

main = do 
    handle <- openFile "girlfriend.txt" ReadMode 
    contents <- hGetContents handle 
    putSTr contents 
    hClose handle

main = do 
    withFile "girlfriend.txt" ReadMode (\handle -> do 
        contents <- hGetContents handle
        putStr contents)

import System.Environment
import System.Directory
import System.IO
import Data.List

dispatch :: [(String, [String] -> IO ())]
dispatch [("add", add)
         ,("views", view)
         ,("remove" remove)]

main = do
    (command:args) <- getArgs
    let (Just action) = lookup command dispatch
    action args

add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")

randomR (1,5) (mkStdGen 3432)
take 10 $ randomRs ('a', 'z') (mkStdGen 3) :: [Char]

main = do
    gen <- getStdGen
    askForNumber gen

askForNumber :: StdGen -> IO ()
askForNumber gen = do 
    let (randNumber, newGen) = randomR (1, 10) gen :: (Int, StdGen) 
    putStr "Which number in the range from 1 to 10 am I thinking of?"
    numberString <- getLine 
    when (not $ null numberString) $ do
        let number = read numberString
            then putStrLn "You are correct!"
            else putStrLn $ "Sorry, it was" ++ show randNumber 
            askForNumber newGen


main = toTry `catch` handler

toTry :: IO ()
toTry = do (fileName:_) <- getArgs
            contents <- readFile fileName 
            putStrLn $ "The file has " ++ show (lenght (lines contents))

handler :: IOError -> IO ()
handler e = putStrLn "Whoops, had some trouble"


