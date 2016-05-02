Find the last element of a list.
myLast :: [a] -> a
myLast [] = error "No end for empty lists"
myLast [x] = x
myLast [_:xs] = myLast xs

myLast' = foldr1 (const id)

myLast'' = foldr1 (flip const)

myLast''' = head . reverse

myLast'''' x = x !! (length x -1)
