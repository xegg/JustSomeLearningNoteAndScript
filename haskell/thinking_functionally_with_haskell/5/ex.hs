scalarMult xs ys = sum (zipwith (*) xs ys)

matMult ma mb = [map (scalarMult row) mbt | row <- ma]
    where mbt = transpose mb


transpose [] = repeat []
transpose (xs:xss) = zipWith (:) xs (transpose xss)

transpose [xs] = zipWith (:) xs (repeat [])
    = [[x] | x <- xs] 

transpose ([]:xss) = []
transpose xss = map head xss:transpose (map tail xss)

{-D-}

nodups :: (Ord a) => [a] -> Bool
nodups xs = and (zipWith (/=) ys (tail ys))
where ys = sort xs

{-E-}
nub :: (Eq a) => [a] -> [a]
nub [] = []
nub (x:xs) = x:nub (filter (/= x) xs)
nub :: (Ord a) => [a] -> [a]
nub = remdups . sort
remdups [] = []
remdups (x:xs) = x:remdups (dropWhile (==x) xs)

{-F-}
takeWhile, dropWhile :: (a -> Bool) -> [a] -> [a]
takeWhile p [] = []
takeWhile p (x:xs) = if p x then x:takeWhile p xs else []
dropWhile p [] = []
dropWhile p (x:xs) = if p x then dropWhile p xs else x:xs

{-G-}
minimum :: Ord a => [a] -> a
minimum [x]
= x
minimum (x:xs) = x `min` minimum xs
