mReverse :: [a] -> [a]
mReverse [] = []
mReverse [x:xs] = mReverse xs : x

