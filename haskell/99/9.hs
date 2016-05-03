pack (x:xs) = let (first, rest) = span (==x) xs in (x:first) : pack rest
pack [] = []

pack [] = []
pack (x:xs) = (x:first) : pack rest
    where
        getReps [] = ([], [])
        getReps (y:ys)
            | y == x = let (f,r) = getReps ys in (y:f, r)
            | otherwise = ([], (y:ys))
        (first, rest) = getReps xs

pack [] = []
pack (x:xs) = (x:reps) : (pack rest)
    where (reps, rest) = maybe (xs, []) (\i -> splitAt i xs)
        (findIndex (/=x) xs)

pack [] = []
pack (x:xs) = (x : takeWhile (==x) xs) : pack (dropWhile (==x) xs)

pack = foldr func []
    where func x [] = [[x]]
          func x (y:xs) = 
              if x == (head y) then ((x:y):xs) else ([x]:y:xs)

pack [] = []
pack [x] = [[x]]
pack (x:xs)
    | x == head h_p_xs = (x:h_p_xs):t_p_hs
    | otherwise = [x]:p_xs
    where p_xs@(h_p_xs:t_p_hs) = pack' xs

pack [] = []
pack (y:ys) = impl ys [[y]]
    where impl [] packed = packed
          impl (x:xs) packed 
            | x == (head (last packed)) = imple xs ((init packed) ++ [x:(last packed)])
            | otherwise = impl xs (packed ++ [[x]])
