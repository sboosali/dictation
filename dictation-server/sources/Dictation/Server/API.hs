{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds         #-}

--------------------------------------------------

{-|



-}

module Dictation.Server.API where

--------------------------------------------------

import Prelude_dictation_server

--------------------------------------------------

import Dictation.Server.Types

--------------------------------------------------

import qualified "servant-server" Servant     as S
---import qualified "servant"        Servant.API as S

--------------------------------------------------

---import qualified "http-client" Network.HTTP.Client      as HTTP (newManager, defaultManagerSettings)
---import qualified "warp"        Network.Wai.Handler.Warp as Warp

--------------------------------------------------

---import qualified "text" Data.Text as T

--------------------------------------------------

--import qualified "time" Data.Time as Time (UTCTime)

--------------------------------------------------

---import qualified "base" Control.Concurrent as Concurrent

--------------------------------------------------

-- import Control.Exception      (bracket)
-- import Control.Monad.IO.Class

--------------------------------------------------

import "base" GHC.TypeLits (Symbol)

--------------------------------------------------
--------------------------------------------------

{- | All the APIs.

e.g.

Testing on UNIX:

@
$ export PORT=8888
$ curl  -X POST  -H "Content-Type: application/json"  -d '["some","words"]'  "http://localhost:$PORT/recognition/"
$ python -c 'import sys,os,json,urllib2; print (urllib2.urlopen(urllib2.Request("http://localhost:"+os.environ["PORT"]+"/recognition/", json.dumps(["some","words with spaces"]), {"Content-Type": "application/json"})).readline())'
@

Testing on Windows:

@
> set PORT=8888
> python -c "import sys,os,json,urllib2; print (urllib2.urlopen(urllib2.Request('http://localhost:'+os.environ['PORT']+'/recognition/', json.dumps(['some','words with spaces']), {'Content-Type': 'application/json'})).readline())"
@

Or run a simple test from the browser, by visiting
(you must change the port if it's not default) the following:

@
http://localhost:8888/test

or

http://127.0.0.1:8888/test
@

-}
type API
       = RecognitionAPI
  S.:<|> TestAPI

--------------------------------------------------

{-| The API for a successful recognition.

@
POST /recognition
@

-}

type RecognitionAPI
  = PostAPI "recognition" Recognition ()

--------------------------------------------------

{-| The API to test that the server

@
POST /test
@

-}

type TestAPI
     = "test"
  S.:> S.Get '[S.JSON] ()

--------------------------------------------------

{-| Signature for a simple "foreign function",
via @JSON@ and @HTTP@.

i.e.:

@
_ :: PostAPI "..." a b
@

is like:

@
_ :: a -> IO b
@

because @POST@ requests can be "effectful".

-}
type PostAPI (s :: Symbol) (a :: *) (b :: *)
    = s
 S.:> S.ReqBody '[S.JSON] a
 S.:> S.Post    '[S.JSON] b

--------------------------------------------------



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

 ------------------------------------------------


{-| Signature for a simple "foreign function",
via @JSON@ and @HTTP@.

i.e.:

@
_ :: GetAPI "..." "..." a b
@

is like:

@
_ :: a -> b
@

because @GET@ requests should be "idempotent".

-}
type GetAPI (s :: Symbol) (q :: Symbol) (a :: *) (b :: *)
    = s
 S.:> S.QueryParam q           a
 S.:> S.Get          '[S.JSON] b

 ------------------------------------------------

-------------------------------------------------}

-- See
--     - https://haskell-servant.readthedocs.io/en/stable/cookbook/db-sqlite-simple/DBConnection.html
--     - 
--

--------------------------------------------------