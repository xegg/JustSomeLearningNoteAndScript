data NestedList a = Elem a | List [NestedList a]
flatten :: NestedList a -> a -> [a]
flatten (Elem x) = [x]
flatten (List x) = concatMap flatten x

flatten (Elem a) = [a]
flatten (List (x:xs)) = flatten x ++ (List xs)
flatten (List []) = []

flatten (Elem x) = return x
flatten (List x) = flatten =<< x

flatten (Elem x) = [x]
flattem (List xs) = foldr (++) [] $ map flatten xs

flatten = reverse . rec []
    where
        rec acc (List []) = acc
        rec acc (Elem x) = x:acc
        rec acc (List (x:xs)) = rec (rec acc x) (List xs)
