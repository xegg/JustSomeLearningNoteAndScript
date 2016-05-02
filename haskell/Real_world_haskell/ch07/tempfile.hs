import System.IO
import System.Directory(getTemporaryDirectory, removeFile)
import System.IO.Error(catch)
import Control.Exception(finally)

main :: IO ()
main = withTempFile "mytemp.txt" myAction

myAction :: FilePath -> Handle -> IO ()
myAction tempname temph = 
    do 
        putStrLn "Welcome to tempfile.hs"
        putStrLn $ "I have a temporary file at " ++ tempname

        -- Let's see what the initial position is
        pos <- hTell temph
        putStrLn $ "My initial position is " ++ show pos

        -- Now, write some data to the temporary file
        let tempdata = show [1..10]
        putStrLn $ "Writing one line containing " ++
            show (length tempdata) ++ " bytes: " ++
               tempdata
        hPutStrLn temph tempdata
        putStrLn "Welcome to tempfile.hs"
        putStrLn $ "I have a temporary file at " ++ tempname

        -- Let's see what the initial position is
        pos <- hTell temph
        putStrLn $ "My initial position is " ++ show pos

        -- Now, write some data to the temporary file
        let tempdata = show [1..10]
        putStrLn $ "Writing one line containing " ++
            show (length tempdata) ++ " bytes: " ++
               tempdata
        hPutStrLn temph tempdata

withTempFile :: String -> (FilePath -> Handle -> IO a) -> IO a
withTempFile pattern func =
    do -- The library ref says that getTemporaryDirectory may raise on
       -- exception on systems that have no notion of a temporary directory.
       -- So, we run getTemporaryDirectory under catch.  catch takes
       -- two functions: one to run, and a different one to run if the
       -- first raised an exception.  If getTemporaryDirectory raised an
       -- exception, just use "." (the current working directory).
       tempdir <- catch (getTemporaryDirectory) (\_ -> return ".")
       (tempfile, temph) <- openTempFile tempdir pattern

       -- Call (func tempfile temph) to perform the action on the temporary
       -- file.  finally takes two actions.  The first is the action to run.
       -- The second is an action to run after the first, regardless of
       -- whether the first action raised an exception.  This way, we ensure
       -- the temporary file is always deleted.  The return value from finally
       -- is the first action's return value.
       finally (func tempfile temph)
               (do hClose temph
                   removeFile tempfile)
