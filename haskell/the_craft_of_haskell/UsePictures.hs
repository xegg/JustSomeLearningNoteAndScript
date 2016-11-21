module UsePictures where
import Pictures hiding (rotate)

blackHorse :: Picture 
blackHorse = invertColour horse


rotate :: Picture -> Picture
rotate = flipH . flipV


rotateHorse :: Picture 
rotateHorse = rotate horse

black :: Picture
black = superimpose horse blackHorse

{-chessBoard :: Picture-}
{-chessBoard = sideBySide  (above white black) (above black white)-}

{-chessBoard :: Picture-}
{-chessBoard = sideBySide  (above blackHorse horse) (above horse blackHorse)-}


eightChessBoard :: Picture
eightChessBoard = above
    (sideBySide
    ( above (sideBySide chessBoard chessBoard) (sideBySide chessBoard chessBoard))
    ( above (sideBySide chessBoard chessBoard) (sideBySide chessBoard chessBoard)))
    (sideBySide
    ( above (sideBySide chessBoard chessBoard) (sideBySide chessBoard chessBoard))
    ( above (sideBySide chessBoard chessBoard) (sideBySide chessBoard chessBoard)))
