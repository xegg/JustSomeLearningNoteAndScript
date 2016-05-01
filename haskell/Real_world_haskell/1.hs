set prompt "ghci>"

:module + Data.Ratio

:info (*) 查看优先级 1最高 9最小 infixl左操作

:set +t 输出打印类型

pred 9 减号操作

truncate pi 截断操作

round 四舍五入

floor 目前看起来像truncate

ceiling 大于这个数的整数

main = interact wordCount
  where wordCount input = show (sum [ 1 | x <- input, x `elem` ['A'..'z']]) ++ "\n'"
