myLength :: [a] -> a
myLength [] = 0
myLength [x] = 1
myLength [_:xs] = 1 + (myLength xs)

myLength list = myLength_acc list 0
  where myLength_acc [] 0
        myLength_acc (_:xs) = myLength_acc xs (n+1)

myLength = foldl (\n _ -> n + 1) 0
myLength = foldr (\_ n -> n + 1) 0
myLength = foldr (\_ -> (+1)) 0

myLength4 =  foldr ((+) . (const 1)) 0
myLength5 =  foldr (const (+1)) 0
myLength6 =  foldl (const . (+1)) 0

myLength = sum . map (\_ -> 1)

myLength = fst . last . zip [1..]
