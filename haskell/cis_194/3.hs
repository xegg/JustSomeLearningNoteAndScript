{-every n xs = case drop (n-1) xs of-}
  {-(y:ys) -> y : every n ys-}
  {-[] -> []-}

every :: (Int, [a]) -> [a]
every (n, xs) = [xs !! i | i <- [n-1, n-1+n..(length xs)-1]]

enumerate :: Int -> [a] -> [(Int, [a])]
enumerate n xs 
  | n == (length xs) = [] 
  | otherwise = ((n+1), xs) : enumerate (n+1) xs

{-enumerate :: [a] -> [(Integer, a)]-}
{-enumerate  = zip [0..] -}

skips :: [a] -> [[a]]
skips xs = map every $ enumerate 0 xs 
skips lst = [each i lst | i <- [1..length lst]]

localMaxima :: [Integer] -> [Integer]
localMaxima [] = []
localMaxima [x] = []
localMaxima [x:y] = []
localMaxima [x:y:z] = if y > x && y > z then [y] else []
localMaxima [x:y:z:zs] = if y > x && y > z then [y] : localMaxima [y:z:zs] else []

localMaxima :: [Integer] -> [Integer]
localMaxima (x:y:z:zs)
  | x < y && y > z = y : localMaxima (y:z:zs)
  | otherwise      = localMaxima (y:z:zs)
localMaxima _ = []

zip (map length  $ group $ sort [1,2,3,2]) (map head $ group $ sort [1,2,3,2])

-- not needed anymore
-- extracts @k@ elements at position @n@
-- > extract 2 3 [1..10] == [3,4]
extract :: Int -> Int -> [Integer] -> [Integer]
extract k n = take k . drop (n-1)

histogram :: [Integer] -> String
histogram xs = unlines (map (line c) [m+1,m..1]) ++ "==========\n0123456789\n"
  where c = count xs
        m = maximum c

-- returns one * line from the above function
line :: [Int] -> Int -> String
line xs n = [if i >= n then '*' else ' ' | i <- xs]

-- counts occurence of numbers in [0..9] in the input list.
count :: [Integer] -> [Int]
{-count xs = map (\n -> length $ filter (== n) xs) [0..9]-}
count xs = [length $ filter (== n) xs | n <- [0..9]]
