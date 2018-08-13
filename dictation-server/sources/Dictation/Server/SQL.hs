{-# LANGUAGE OverloadedStrings #-}

--------------------------------------------------

{-|



-}

module Dictation.Server.SQL where

--------------------------------------------------
import qualified Data.Text as T
--------------------------------------------------
import           Database.SQLite.Simple
--import           Database.SQLite.Simple.FromRow
--------------------------------------------------
--import qualified "sqlite-simple" Database.SQLite.Simple as SQL
--------------------------------------------------
import           Control.Applicative
--------------------------------------------------
import           Prelude
--------------------------------------------------
--------------------------------------------------

data TestField = TestField Int T.Text deriving (Show)

instance FromRow TestField where
  fromRow = TestField <$> field <*> field

instance ToRow TestField where
  toRow (TestField id_ str) = toRow (id_, str)

--------------------------------------------------

main :: IO ()
main = do
  conn <- open "test.db"
  
  execute_ conn "CREATE TABLE IF NOT EXISTS test (id INTEGER PRIMARY KEY, str TEXT)"
  
  execute conn "INSERT INTO test (str) VALUES (?)" (Only ("test string 2" :: String))
  
  execute conn "INSERT INTO test (id, str) VALUES (?,?)" (TestField 13 "test string 3")
  
  rowId <- lastInsertRowId conn
  executeNamed conn "UPDATE test SET str = :str WHERE id = :id"
    [ ":str" := ("updated str" :: T.Text)
    , ":id" := rowId
    ]
  
  r <- query_ conn "SELECT * from test" :: IO [TestField]
  mapM_ print r
  
  execute conn "DELETE FROM test WHERE id = ?" (Only rowId)

  close conn

--------------------------------------------------



--------------------------------------------------
--------------------------------------------------
{-





--------------------------------------------------
--------------------------------------------------



--------------------------------------------------

--import qualified "base"      System.Exit      as IO
import qualified "directory" System.Directory as IO
--import qualified "base"      System.IO        as IO

--------------------------------------------------
--------------------------------------------------

{-|

-}

newtype Message = Message

  Text

  deriving stock    (Show,Read,Lift,Generic)
  deriving newtype  (Eq,Ord,Semigroup,Monoid)
  deriving newtype  (NFData,Hashable)

instance IsString Message where
  fromString = coerce > fromString

--------------------------------------------------

{-|

-}
main :: IO ()
main = do
  let dbfile = "./db/messages.db"
  
  mkdir "./db"

  p_dbfile <- IO.canonicalizePath dbfile
  print $ p_dbfile

  p_sqlite <- IO.findExecutable "sqlite3"
  print $ p_sqlite
  
  initDB dbfile

  --TODO _ <- IO.exitSuccess
  
  postMessage dbfile `traverse_`
    [ "first message", "second message", "third message" ]
  
  messages <- getMessages dbfile
  print `traverse_` messages

--------------------------------------------------

-- | @mkdir -p@
mkdir :: FilePath -> IO ()
mkdir = IO.createDirectoryIfMissing True

--------------------------------------------------

{-|

-}

initDB :: FilePath -> IO ()
initDB dbfile = SQL.withConnection dbfile initDB'

initDB' :: SQL.Connection -> IO ()
initDB' connection =
  SQL.execute_ connection sql_CreateTable

sql_CreateTable :: SQL.Query
sql_CreateTable
  = "CREATE TABLE IF NOT EXISTS messages (message text not null)"

--------------------------------------------------

{-|

-}

postMessage :: FilePath -> Message -> IO ()
postMessage dbfile message 
  = SQL.withConnection dbfile (postMessage' message)

postMessage' :: Message -> SQL.Connection -> IO ()
postMessage' (Message message) connection
  = SQL.execute connection sql1 (SQL.Only message)

  where
  sql1 :: SQL.Query
  sql1 = "INSERT INTO messages VALUES (?)"

--------------------------------------------------

{-|

-}

getMessages :: FilePath -> IO [Message]
getMessages dbfile
  = go (SQL.withConnection dbfile getMessages')
  where

  go = fmap (map toMessage)
  toMessage = SQL.fromOnly > Message

getMessages' :: SQL.Connection -> IO [SQL.Only Text]
getMessages' connection
  = SQL.query_ connection sql0

  where
  sql0 :: SQL.Query
  sql0 = "SELECT message FROM messages"

-}
--------------------------------------------------