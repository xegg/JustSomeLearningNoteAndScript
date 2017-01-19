{-:module Database.HDBC Database.HDBC.Sqlite3-}

conn <- connectSqlite3 "test1.db"

{-run conn "CREATE TABLE test (id INTEGER NOT NULL, desc VARCHAR(80))" []-}
{-run conn "INSERT INTO test (id) VALUES (0)" []-}
{-run conn "INSERT INTO test VALUES (0, ?)" [toSql "zero"]-}


{-stmt <- prepare conn "INSERT INTO test VALUES (?, ?)"-}

{-execute stmt [toSql "1", toSql "one"]-}
{-execute stmt [toSql 4, SqlNull]-}

{-executeMany stmt [[toSql "5", toSql "five's nice"], [toSql "6", SqlNull]]-}
{-commit conn-}
{-quickQuery' conn "SELECT * from test where id < 2" []-}

