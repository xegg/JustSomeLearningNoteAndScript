--6.1

superimposeChar:: Char -> Char -> Char
superimposeChar ch1 ch2 
  |ch1==ch2 &&  ch1=='.'        ='.'
  |otherwise                        ='#'
  
--6.2

superimposeLine:: [Char] -> [Char] -> [Char]
superimposeLine chars1 chars2 = [superimposeChar ch1 ch2 |(ch1, ch2) <- zip chars1 chars2 ] 

--6.3

type Picture = [[Char]]

superimpose :: Picture -> Picture -> Picture
superimpose pic1 pic2 = [superimposeLine chars1 chars2 | (chars1, chars2) <- zip pic1 pic2 ]

--6.4

printPicture :: Picture -> IO()
printPicture pic = putStrLn (onSeperateLines pic)

--6.6

--To get one element of a line of the picture where x is the element number of the line
anElement :: [Char] -> Int -> Char
anElement line x = line!!x

oneLineRotate90 :: Picture -> Int -> [Char]
oneLineRotate90 pic elementofline = reverse [anElement line elementofline | line <- pic ]

rotate90 :: Picture -> Picture 
rotate90 pic = [oneLineRotate90 pic n | n <- [0..(length(pic!!0)-1)] ]

--6.7

antiRotate90 ::Picture -> Picture
antiRotate90 pic = reverse [reverse (oneLineRotate90 pic n) | n <- [0..(length(pic!!0)-1)] ]

--6.8

oneElementScale :: Char -> Int -> [Char]
oneElementScale element scalingnumber = replicate scalingnumber element

oneLineScaleH :: [Char] -> Int -> [Char]
oneLineScaleH line scalingnumber
        |line/=""        = (oneElementScale (head(line)) scalingnumber) ++ (oneLineScaleH (drop 1 line) scalingnumber)
        |otherwise         =""

oneLineScaleHV :: [Char] -> Int -> Picture
oneLineScaleHV line scalingnumber = --[oneLineScaleH line scalingnumber | n <- [1..scalingnumber]]
        replicate scalingnumber (oneLineScaleH line scalingnumber)

scale :: Picture -> Int -> Picture
scale pic scalingnumber
        | pic/=[]         =(oneLineScaleHV (head(pic)) scalingnumber) ++ (scale (drop 1 pic) scalingnumber) 
        | otherwise          =[]

--6.9

horse :: Picture

horse = [".......##...",
         ".....##..#..",
         "...##.....#.",
         "..#.......#.",
         "..#...#...#.",
         "..#...###.#.",
         ".#....#..##.",
         "..#...#.....",
         "...#...#....",
         "....#..#....",
         ".....#.#....",
         "......##...."]


type Position = (Int, Int) 
type Image = (Picture, Position)

small:: Image
small=(["12","34","56"], (5,5))

horseimg ::Image
horseimg = (horse, (3,7))

horseimg2 :: Image
horseimg2 = (horse, (0,0))

makeImage :: Picture -> Position -> Image
makeImage pic pos = (pic, pos)

--6.10

frt (x,y) = x

scd(x,y)=y
 
changePosition :: Image -> Position -> Image 
changePosition img newpos = (frt img, newpos)
  
--6.11

makePosition :: Int -> Int -> Position 
makePosition a b = (a, b)

moveImage :: Image -> Int -> Int -> Image
moveImage img moveX moveY = changePosition img ((frt(scd img)+ moveX), (scd(scd img) + moveY))

--6.12

addWhiteX :: Picture -> Int -> Picture
addWhiteX pic x = [addSpace line x | line <- pic ]

makeWhiteY :: Int -> String
makeWhiteY 0 = ""
makeWhiteY y = (makeWhiteY (y - 1)) ++ "\n"

addWhiteYLine :: String -> Int ->  String
addWhiteYLine lastline y = lastline ++ (makeWhiteY y)

addWhiteY :: Picture -> Int -> Picture
addWhiteY pic y = (init pic) ++ [addWhiteYLine (last pic) y]

place :: Image -> Picture
place img = addWhiteY (addWhiteX (frt img)(frt(scd(img)))) (scd(scd(img)))

printImage ::Image -> IO()
printImage img = printPicture (place img)

--6.13

flipV :: Picture -> Picture
flipV = map reverse

flipH :: Picture -> Picture
flipH = reverse

rotate :: Picture -> Picture
rotate = flipH . flipV

naiveFlipH :: Image -> Image 
naiveFlipH img = ((flipH (frt img)), (scd img))

naiveFlipV :: Image -> Image 
naiveFlipV img = ((flipV (frt img)), (scd img))

naiveRotate :: Image -> Image 
naiveRotate img = ((rotate (frt img)), (scd img))

naiveRotate90 :: Image -> Image 
naiveRotate90 img = ((rotate90 (frt img)), (scd img))

--6.14

geometricalFlipH :: Image -> Image 
geometricalFlipH img = moveImage (naiveFlipH img) 0 (negate(length (frt img)+1)) 

geometricalFlipV :: Image -> Image 
geometricalFlipV img = moveImage (naiveFlipV img) (negate(length (head (frt img))+1)) 0 

geometricalRotate :: Image -> Image
geometricalRotate img = moveImage (naiveRotate img) (negate(length (head (frt img))+1)) (negate(length (frt img)+1))

geometricalRotate90 :: Image -> Image
geometricalRotate90 img = moveImage (naiveRotate90 img) (negate(length (head (frt img))+1)) (negate(length (frt img)+1))
