--4.1

maxThree :: Int -> Int -> Int -> Int
maxThree x y z = max (max x y) z

maxFour:: Int -> Int -> Int -> Int -> Int 
--maxFour w x y z = max ( max w x) (max y z)
--maxFour w x y z = max (maxThree w x y) z
maxFour w x y z = maxThree (maxThree w x y) (maxThree x y z) (maxThree y z w)

--4.2

weakAscendingOrder :: Int -> Int -> Int -> Bool 
weakAscendingOrder a b c
	|(a >= b) && (b >= c)                =True
	|otherwise                           =False
	
weakDesendingOrder :: Int -> Int -> Int -> Bool 
weakDesendingOrder a b c
	|(a <= b) && (b <= c)                =True
	|otherwise                           =False	

between :: Int -> Int -> Int -> Bool 
between a b c = weakAscendingOrder a b c || weakDesendingOrder a b c
	
--4.3 

threeEqual :: Int -> Int -> Int -> Bool
threeEqual m n p = (m==n) && (m==p)

twoEqual :: Int -> Int -> Bool 
twoEqual m n = (m == n)

howManyEqual :: Int-> Int -> Int -> Int
howManyEqual a b c 
	|threeEqual a b c == True 		=3
	|twoEqual a b || twoEqual b c		=2
	|otherwise				=0

--4.4

fourEqual :: Int -> Int-> Int -> Int-> Bool
fourEqual m n p q = (m==n) && (m==p) && (m==q)

howManyOfFourEqual :: Int-> Int -> Int -> Int -> Int
howManyOfFourEqual a b c d
	|fourEqual a b c d			                       =4
	|threeEqual a b c || threeEqual b c d || threeEqual c d a || threeEqual d a b      =3
	|twoEqual a b || twoEqual b c || twoEqual c d ||twoEqual d a   =2
	|otherwise				                       =0


fac :: Int -> Int
fac n
  | n==0        = 1
  | n>0         = fac (n-1) * n
  | otherwise   = error "fac only defined on natural numbers"

rangeProduct :: Int -> Int -> Int
rangeProduct m n
    | n < m = 0
    | n == m = m
    | otherwise = m * rangeProduct m+1 n


--4.6	
fac :: Int -> Int
fac x
	| x > 0 	= rangeProduct 1 x 
	|otherwise	= error "fac only defined on natural numbers"

sumFun :: (Int -> Int) -> Int -> Int
sumFun f n
  | n==0        = f 0
  | n>0         = sumFun f (n-1) + f n  


regions :: Int -> Int 
regions n
  | n==0        = 1
  | n>0         = regions (n-1) + n



--4.8
 
square :: Int -> Int
square n = n^2

sqrtTest :: Int -> Int -> Int 
sqrtTest x a 
    |square a > x   = sqrtTest x (a-1)
	|square a <= x  = a    
   
sqrtInt :: Int -> Int 
--sqrtInt a =  floor (sqrt(fromIntegral a)) 
sqrtInt x = sqrtTest x (div x 2) 

{-TODO : 立方体切割的和-}
