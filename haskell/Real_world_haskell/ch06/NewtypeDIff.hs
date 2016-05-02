noewtype NewtypeInt = N Int deriving (Show, Ord, Show)

-- file: ch06/NewtypeDiff.hs
-- 可以：任意数量的构造器和字段（这里的两个Int为两个字段(fields)）
data TwoFields = TwoFields Int Int

-- 可以：恰一个字段
newtype Okay = ExactlyOne Int

-- 可以：类型变量是没问题的
newtype Param a b = Param (Either a b)

-- 可以：记录语法是友好的
newtype Record = Record {
        getInt :: Int
    }

-- 不可以：没有字段
newtype TooFew = TooFew

-- 不可以：多于一个字段
newtype TooManyFields = Fields Int Int

-- 不可以：多于一个构造器
newtype TooManyCtors = Bad Int
                     | Worse Int
