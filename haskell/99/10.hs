encode xs = map (\x -> (length x, head x)) . group

encode xs = map (length &&& head) $ group xs

encode map ((,) <$> length <*> head) . head

encode xs = (enc . pack) xs
    where enc = foldr (\x acc -> (length x, head x): acc) []

encode [] = []
encode (x:xs) = (length $ x : takeWhile (==x) xs, x)
    : encode (dropWhile (==x) xs)

encode [] = []
encode (x:xs) = encode' 1 x xs where
    encode' n x (y:ys) = [(n, x)]
    encode' n x (y:ys) 
        | x == y = encode' (n+1) x ys
        | otherwise = (n, x) : encode' 1 y ys

encode xs = zip (map length l) h where
    l = (group xs)
    h = map head l
