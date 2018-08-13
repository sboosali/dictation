{-# LANGUAGE OverloadedStrings #-}

--------------------------------------------------

{-|



-}

module Dictation.Server.API where

--------------------------------------------------

import Prelude_dictation_server

--------------------------------------------------

import qualified "servant-server" Servant     as S
import qualified "servant"        Servant.API as S

--------------------------------------------------

import qualified "sqlite-simple" Database.SQLite.Simple as SQL

--------------------------------------------------

import qualified "http-client" Network.HTTP.Client      as HTTP (newManager, defaultManagerSettings)
import qualified "warp"        Network.Wai.Handler.Warp as Warp

--------------------------------------------------

import qualified "text" Data.Text as T

--------------------------------------------------

import qualified "time" Data.Time as Time (UTCTime)

--------------------------------------------------

import qualified "base" Control.Concurrent as Concurrent

--------------------------------------------------

-- import Control.Exception      (bracket)
-- import Control.Monad.IO.Class

--------------------------------------------------
--------------------------------------------------



--------------------------------------------------




--------------------------------------------------
-- NOTES -----------------------------------------
--------------------------------------------------

-- See
--     - https://haskell-servant.readthedocs.io/en/stable/cookbook/db-sqlite-simple/DBConnection.html
--     - 
--

--------------------------------------------------