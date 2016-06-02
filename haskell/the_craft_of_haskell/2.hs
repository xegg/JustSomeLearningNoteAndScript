size :: Int
size = 12 + 13

square :: Int -> Int
square n = n * n

double :: Int -> Int
double n = 2 * n

example :: Int
example = double(size - square (2+2))

double_square :: Int -> Int
double_square n = square $ double n

square_double :: Int -> Int
square_double n = double $ square n
