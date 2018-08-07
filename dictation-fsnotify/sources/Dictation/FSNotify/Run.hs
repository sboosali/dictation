
--------------------------------------------------

module Dictation.FSNotify.Run where

--------------------------------------------------

import Prelude_dictation_fsnotify

--------------------------------------------------

import Dictation.FSNotify.Types

--------------------------------------------------

import qualified "fsnotify" System.FSNotify as FS

--------------------------------------------------

main =

  FS.withManagerConf FS.defaultConfig $ \manager -> do

    -- start a watching job (in the background)
    FS.watchDir
      manager          --
      "."          -- directory to watch
      (const True) -- predicate
      print        -- action

    -- sleep forever (until interrupted)
    forever $ threadDelay 1000000

--------------------------------------------------



--------------------------------------------------