import Data.List

solveRPN :: String -> Float
solveRPN = head . foldl foldingFunction [] . words
    where foldingFunction (x:y:ys) "*" = (x * y):ys
          foldingFunction (x:y:ys) "+" = (x + y):ys
          foldingFunction (x:y:ys) "-" = (y - x):ys
          foldingFunction (x:y:ys) "/" = (y / x):ys
          foldingFunction (x:y:ys) "^" = (y ** x):ys
          foldingFunction (x:y:ys) "Ln" = log x:ys
          foldingFunction xs "sum" = [sum xs]
          foldingFunction xs numberString = read numberString:xs

data Node = Node Road Road | EndNode Road
data Road = Road Int Node

data Section = Section { getA :: Int, getB :: Int, getC :: Int } deriving (Show)
type RoadSystem = [Section]

heathrowToLondon :: RoadSystem
heathrowToLondon = [Section 50 10 30, Section 5 90 20]

data Label = A | B | C deriving (Show)
type Path = [(Label, Int)]

roadStep :: (Path, Path) -> Section -> (Path, Path)
roadStep (pathA, pathB) (Section a b c) =
    let priceA = sum $ map snd pathA
        priceB = sum $ map snd pathB
        forwardPriceToA = priceA + a
        crossPriceToA = priceB + b + c
        forwardPriceToB = priceB + b
        crossPriceToB = priceA + a + c
        newPathToA = if forwardPriceToA <= crossPriceToA
                        then (A, a):pathA
                        else (C, c):(B,b):pathB
        newPathToB = if forwardPriceToB <= crossPriceToB
                        then (B, b):pathB
                        else (C, c):(A,a):pathA
    in (newPathToA, newPathToB)

optimalPath :: RoadSystem -> Path
optimalPath roadSystem =
    let (bestAPath, bestBpath) = foldl roadStep ([], []) roadSystem
    in if sum (map snd bestAPath) <= sum (map snd bestBpath)
        then reverse bestAPath 
        else reverse bestBpath

main = do 
    contents < getContents
    let threes = groupOf 3 (map read $ lines contests)
        roadSystem = map (\[a, b, c] -> Section a b c ) threes
        path = optimalPath roadSystem 
        pathString = concat $ map (show . fst) path 
        pathPrice = sum $ map snd path 
    printStrLn $ "The best path to take is : " ++ pathString 
    putStrLn $ "The price is " ++ show pathPrice
