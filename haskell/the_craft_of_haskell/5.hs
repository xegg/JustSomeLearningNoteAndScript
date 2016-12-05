--5.1

maxOccurs :: Int -> Int -> (Int, Int)  
maxOccurs x y 
	|(x == max x y) && (y == max x y) = (max x y, 2)
	| otherwise 			  = (max x y, 1)


maxThreeOccurs :: Int -> Int -> Int -> (Int, Int)
maxThreeOccurs x y z = (maxThree x y z, (howManyOfFourEqual (maxThree x y z) x y z) -1 ) 
			
--5.2

middleNumber x y z
	|between y x z	= x
	|between x y z  = y
	|otherwise 	= z

orderTriple :: (Int, Int, Int) -> (Int, Int, Int)
orderTriple (x, y, z) = (maxThree x y z, middleNumber x y z, minThree x y z) 

--5.3

xInt:: (Float, Float) -> Float
xInt (slope, yint) = negate (slope/yint)

--5.8

doubleAll:: [Int] -> [Int]
doubleAll ex = [2*n| n <- ex ]

--5.9

capitalizeLetters:: String -> String 
capitalizeLetters ex = [ toUpper ch | ch <- ex ]

--5.10

divisor :: Int -> Int -> Bool
divisor x i 
	|mod x i ==0		=True
	|otherwise 		=False


divisors :: Int -> [Int]
divisors n = [x | x <- [n, (n-1) .. 1], divisor n x ] 

isPrime :: Int -> Bool
isPrime n
	|divisors n == [n, 1]   =True
	|otherwise 		=False

--5.11

matches :: Int -> [Int] -> [Int] 
matches n list = [ x | x <- list , x==n] 

element :: Int -> [Int] -> Bool
element n list 
	|matches n list == [] = False
	|otherwise         = True
	
