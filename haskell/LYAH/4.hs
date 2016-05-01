calcBmis :: (RealFloat a) => [(a,a)] -> [a]

-- where bound with function
calcBmis xs = [bmi w h | (w, h) <- xs]
  where bmi weight height = weight / height ^2

addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors a b = (fst a + fst b, snd a + snd b)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

-- because let is expresion, it can put in anywhere
cylinder r h = 
  let sideArea = 2 * pi * r * h
    topArea = pi * r ^2
  in sideArea + 2 * topArea

4 * (let a = 9 in a + 1) + 2
-- local function
[let square x = x * x in (square 5, square 3, square 2)]

(let a = 100; b = 200; c = 300 in a * b *c)

[bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi >= 25]
