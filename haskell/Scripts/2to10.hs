-- not work
convert_base :: Int -> [Int]
convert_base n d = bool (convert_base(floor (n / d)) : n `mod` d : []) [] n==0   
convert_base n d = if n==0 then [] else (convert_base floor(n/d) d) : n `mod` d : []
convert_base n d | n == 0 = [] | otherwise = convert_base floor(n/d) d : n `mod` d 
