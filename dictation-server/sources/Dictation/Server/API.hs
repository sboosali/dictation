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

---import qualified "http-client" Network.HTTP.Client      as HTTP (newManager, defaultManagerSettings)
---import qualified "warp"        Network.Wai.Handler.Warp as Warp

--------------------------------------------------

---import qualified "text" Data.Text as T

--------------------------------------------------

import qualified "time" Data.Time as Time (UTCTime)

--------------------------------------------------

---import qualified "base" Control.Concurrent as Concurrent

--------------------------------------------------

-- import Control.Exception      (bracket)
-- import Control.Monad.IO.Class

--------------------------------------------------
--------------------------------------------------

type UserAPI
    =               "users"
  S.:> S.QueryParam "sortby" SortBy
  S.:> S.Get '[S.JSON] [User]

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
main :: IO ()
main = do
  nothing

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

{-------------------------------------------------

    type UserAPI
        =               "users"
      S.:> S.QueryParam "sortby" SortBy
      S.:> S.Get '[S.JSON] [User]

- "users" says that our endpoint will be accessible under /users;

- QueryParam "sortby" SortBy, where SortBy is defined by data SortBy = Age | Name, says that the endpoint has a query string parameter named sortby whose value will be extracted as a value of type SortBy;

- The :> operator that separates the various “combinators” just lets you sequence static path fragments, URL captures and other combinators. The ordering only matters for static path fragments and URL captures:
  "users" :> "list-all" :> Get '[JSON] [User]
equivalent to:
  /users/list-all

 ------------------------------------------------

[Delete, Get, Patch, Post, Put]

The Get combinator is defined in terms of the more general Verb:

    data Verb (method :: k)
              (statusCode :: Nat)
              (contentType :: [*])
              a

    type Get     = Verb 'GET 200
    type GetJSON = Verb 'GET 200 '['JSON]

There are other predefined type synonyms for other common HTTP methods, such as e.g.:

    type Delete = Verb 'DELETE 200
    type Patch  = Verb 'PATCH  200
    type Post   = Verb 'POST   200
    type Put    = Verb 'PUT    200

There are also variants that do not return a 200 status code, such as for example:

    type PostCreated  = Verb 'POST 201
    type PostAccepted = Verb 'POST 202

-------------------------------------------------}

-- See
--     - https://haskell-servant.readthedocs.io/en/stable/cookbook/db-sqlite-simple/DBConnection.html
--     - 
--

--------------------------------------------------