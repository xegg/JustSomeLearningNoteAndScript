isPalindrome :: (Eq a) =>> [a] -> Bool
isPalindrome xs = xs == (reverse xs)

isPalindrome [] = True
isPalindrome [_] = True
isPalindrome xs = (head xs) == (last xs) && (isPalindrome $ init $ tail xs)

isPalindrome xs = foldl' (\acc (a,b) -> if a == b then acc else False) True input
    where input = zip . xs $ reverse xs

isPalindrome :: (Eq a)=> [a] -> Bool
isPalindrome = (==) Control.Applicative.<*> reverse 

isPalindrome xs = p [] xs xs
    where p rev (x:xs) (_:_:ys) = p (x:rev) xs ys
          p rev (x:xs) [_] = rev == xs
          p rev xs [] = rev == xs

isPalindrome xs = and $ zipWith (==) xs (reverse xs)

isPalindrome list = take half_len list == reverse (drop (half_len + (len `mod` 2)) list)
    where
        len = length list
        half_len = len `div` 2

isPalindrome list = f_part == reverse s_part
    where
        where len = length list
              harf_len = len `div` 2
              (f_part, s_part) = splitAt half_len list
              s_part = drop (len `mod` 2) s_part

-- WARNING
isPalindrome = (uncurry (==) . (id &&& reverse))
