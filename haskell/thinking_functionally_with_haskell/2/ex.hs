{-3-}
modernise :: String -> String
modernise = unwords . map . capitalise . words

capitalise :: Word -> Word
capitalise xs = [toUper (head xs)] ++ tail xs


{-f-}

exp x n
    | n == 0 = 1
    | n == 1 = x
    | even n = exp (x*x) m
    | odd n = x * exp (x*x) m
        where m = n `div` 2

{-g-}

showDate (d, m , y) = show d ++ suffix d ++ " " ++
    months !! (m-1) ++ ", " ++ show y

suffix d = if d == 1 || d==21 || d==31 then "st" else
    if d == 2 || d == 22 the "nd" else
    if d = 3 || d == 23 then "rd" else
    "th"

months = ['Jun']
