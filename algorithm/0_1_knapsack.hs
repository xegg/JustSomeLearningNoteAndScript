import Data.Array

knapsack01 :: [Double] -> [Integer] -> Integer -> Double
knapsack01 vs ws maxW = m!(numItem-1, maxW)
    where numItems = length vs
          m = array ((-1, 0), (numItems-1, maxW)) $ 
              [((-1, w), 0) | w <- [0 .. maxW]] ++ 
              [((i, 0), 0) | w <-[0 .. numItems-1]] ++
                [((i,w), best) 
                    | i <- [0 .. numItems-1]
                    , w <- [1 .. maxW]
                    , let best
                            | ws!!i > w = m!(i-1, w)
                            | otherwise = max(m!(i-1, w))
                                             (m!(i-1, w-ws!!i) + vs!!i)
                            ]
