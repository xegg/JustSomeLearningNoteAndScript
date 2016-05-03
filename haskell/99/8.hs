
{-compress :: [a] -> [a]-}
## WARNING
compress x = foldl (\a b -> if (last a) == b then a else a ++ [b]) [head x] x
compress x = foldr (\a b -> if a == (head b) then b else a:b) [last x] x

compress = map head . group

compress (x:ys@(y:_))
    | x == y = compress ys
    | otherwise = x : compress ys

compress [] = []
compress (x:xs) = x : (compress $ dropWhile (== x) xs)

## WARNING
compress xs = build (\c n ->
    let
        f x r a@(Just q) | x == q = r a
        f x r _ = x `c` r (Just x)
    in
        foldr f (const n) xs Nothing)
