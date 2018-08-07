{-# LANGUAGE DuplicateRecordFields #-}

--------------------------------------------------

{-|


-}

module Dictation.FSNotify.Types where

--------------------------------------------------

import Prelude_dictation_fsnotify

--------------------------------------------------

import qualified "fsnotify" System.FSNotify  as FSNotify

--import qualified "time"     Data.Time.Clock  as Time
import qualified "thyme"    Data.Thyme.Clock as Thyme

--------------------------------------------------



--------------------------------------------------



--------------------------------------------------

{-|


-}

data FSNotifyConfig = FSNotifyConfig

  { notificationPredicate :: FSNotify.ActionPredicate
  , notificationHandler   :: FSNotify.Action
  , directoryWatched      :: FilePath
  }

  deriving stock    (Generic)

--------------------------------------------------

-- | Isomorphic to 'FSNotify.Event', but more explicit.
--
-- (just with [1] newtypes; [2] refactored into a product-of-sums, for fields; [3] and a self-documenting boolean).
--

data FileNotification = FileNotification
  { fileChange        :: FileChange
  , isDirectory       :: IsDirectory
  , canonicalFilePath :: FilePath
  , timestamp         :: Thyme.UTCTime
  }

  deriving stock    (Eq,Ord,Generic)
  deriving anyclass (NFData)

--------------------------------------------------

{-|


-}

data FileChange

  = FileAdded
  | FileModified
  | FileRemoved

  deriving stock    (Show,Read,Eq,Ord,Enum,Bounded,Ix,Lift,Generic)
  deriving anyclass (NFData,Hashable)

 -- UnknownFileChange

--------------------------------------------------

{-|


-}

data IsDirectory

  = NotDirectory
  | YesDirectory

  deriving stock    (Show,Read,Eq,Ord,Enum,Bounded,Ix,Lift,Generic)
  deriving anyclass (NFData,Hashable)

--------------------------------------------------