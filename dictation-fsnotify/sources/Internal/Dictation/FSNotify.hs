{-# LANGUAGE DuplicateRecordFields #-}

--------------------------------------------------

module Internal.Dictation.FSNotify where

--------------------------------------------------

import Prelude_dictation_fsnotify

--------------------------------------------------

import Dictation.FSNotify.Types

--------------------------------------------------

import qualified "fsnotify" System.FSNotify as FS

--------------------------------------------------

watchDirectoryRecursively
  :: FS.WatchManager
  -> FileNotificationConfiguration
  -> IO FS.StopListening
watchDirectoryRecursively manager FileNotificationConfiguration{..}
  = FS.watchTree manager directory notificationPredicate notificationHandler

--------------------------------------------------

 

--------------------------------------------------