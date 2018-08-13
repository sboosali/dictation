{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds         #-}

--------------------------------------------------

{-|



-}

module Dictation.Server.API where

--------------------------------------------------

import Prelude_dictation_server

--------------------------------------------------

import qualified "servant-server" Servant     as S
---import qualified "servant"        Servant.API as S

--------------------------------------------------

import qualified "sqlite-simple" Database.SQLite.Simple as SQL

--------------------------------------------------

---import qualified "http-client" Network.HTTP.Client      as HTTP (newManager, defaultManagerSettings)
---import qualified "warp"        Network.Wai.Handler.Warp as Warp

--------------------------------------------------

---import qualified "text" Data.Text as T

--------------------------------------------------

import qualified "time" Data.Time as Time (UTCTime)

--------------------------------------------------

---import qualified "base" Control.Concurrent as Concurrent

--------------------------------------------------

import qualified "base"      System.Exit      as IO
import qualified "directory" System.Directory as IO
--import qualified "base"      System.IO        as IO

--------------------------------------------------

-- import Control.Exception      (bracket)
-- import Control.Monad.IO.Class

--------------------------------------------------
--------------------------------------------------

type UserAPI
  = "users" S.:> S.QueryParam "sortby" SortBy S.:> S.Get '[S.JSON] [User]

-------------------------------------------------

-- | a @kind@
data SortBy
  = Age
  | Name

-------------------------------------------------

-- | 
data User = User
  { name              :: String
  , age               :: Int
  , email             :: String
  , registration_date :: Time.UTCTime
  }

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

--------------------------------------------------

{-|

-}

--------------------------------------------------

{-|

-}

--------------------------------------------------

{-|

-}

--------------------------------------------------

{-|

-}

--------------------------------------------------

{-|

-}

--------------------------------------------------

{-|

-}

--------------------------------------------------

{-|

-}

--------------------------------------------------

{-|

-}

--------------------------------------------------

{-|

-}

--------------------------------------------------

{-|

-}

--------------------------------------------------

{-|

-}

--------------------------------------------------

{-|

-}

--------------------------------------------------

{-|

-}

--------------------------------------------------

{-|

-}

--------------------------------------------------

{-|

-}

--------------------------------------------------
-- NOTES -----------------------------------------
--------------------------------------------------

-- See
--     - https://haskell-servant.readthedocs.io/en/stable/cookbook/db-sqlite-simple/DBConnection.html
--     - 
--

--------------------------------------------------