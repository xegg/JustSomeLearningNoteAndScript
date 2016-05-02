-- Find the K'th element of a list.

elementAt :: [a] -> Int -> a
elementAt list n
    | length list < n = error "too large"
    | n <= 0 = error "please input > 0"
    | otherwise  = list !! (n-1)

{-elementAt' list n-}
    {-| length list < n = error "too large"-}
    {-| n <= 0 = error "please input > 0"-}
    {-| otherwise  = fst . last $ zip xs [1..n]-}

{-elementAt_w' xs n = head . reverse . take n $ xs -- wrong-}

elementAt_w'pf = (last .) . take . (+ 1)

-- WARNING
c = last . init
c = (last .) init
