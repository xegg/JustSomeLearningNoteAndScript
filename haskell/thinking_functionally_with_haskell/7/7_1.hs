foldl' f e [] = e
foldl' f e (x:xs) = y `seq` foldl' f y xs
    where y = f e x

{-subseqs (x:xs) = subseqs xs ++ map (x:) (subseqs xs)-}
{-subseqs (x:xs) = xss ++ map (x:) xss-}
    {-where xss = subseqs xs-}

foo1 n = sum (take n primes)
    where 
        primes = [x | x <- [2..], divisors x == [x]]
        divisors x = [d | d <- [2..x], x `mod` d == 0]

foo2 n = sum (take n primes)
primes = [x | x<- [2..], divisors x == [x]]
divisors x = [d | d <-[2..x], x `mod` d == 0]


{-mean xs = sum xs / fromIntegral (length xs)-}

{-sumlen (x:xs) = (s+x, n+1) where (s, n) = sumlen xs-}

{-sumlen1 = foldr f (0,0) where f x (s,n)  = (s+x,n+1)-}

sumlen2 = foldl' f (0,0)
    where f (s,n) x = s `seq` n `seq` (s+x, n+1)

cp [] = [[]]
cp (xs:xss) = [x:ys | x <- xs, ys <- cp xss]
