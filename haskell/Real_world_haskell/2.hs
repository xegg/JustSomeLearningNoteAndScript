myDrop :: Int -> [Int] -> [Int]
myDrop n xs = if n < 0 || null xs
  then xs
  else myDrop (n-1) (tail xs)
