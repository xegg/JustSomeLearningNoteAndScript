import Control.Exception
import Database.HDBC
import Database.HDBC.PostgreSQL (connectPostgreSQL)

{-state <- prepare c "INSERT INTO testtable values (?,?);"-}
{-execute state [toSql "muhmuh", toSql (40::Int)]-}
{-commit c-}

main :: IO () 
main = do
    c <- connectPostgreSQL "host=10.0.10.2 dbname=qipaidb user=pgsql password=123456"
    select <- prepare c "SELECT * FROM user_user limit 1;"
    execute select []
    result <- fetchAllRows select
    putStrLn $ show result
    disconnect c
    return ()
