--------------------------------------------------

{-|


-}

module Dictation.FSNotify

 ( module Dictation.FSNotify.Types
 , module Dictation.FSNotify.Run
 ) where

--------------------------------------------------

import Dictation.FSNotify.Types
import Dictation.FSNotify.Run

--------------------------------------------------

{-



Added FilePath UTCTime Bool	 
Modified FilePath UTCTime Bool	 
Removed FilePath UTCTime Bool	 
Unknown FilePath Unknown String




> withManagerConf 
>     :: WatchConfig -> (WatchManager -> IO a) -> IO a



> data WatchConfig



> defaultConfig :: WatchConfig 

Debouncing is enabled with a time interval of 1 millisecond
Polling is disabled




> data Debounce 


> | DebounceDefault	
perform debouncing based on the default time interval of 1 millisecond

> | Debounce NominalDiffTime	
perform debouncing based on the specified time interval

> | NoDebounce	
do not perform debouncing


This specifies whether multiple events from the same file should be collapsed together, and how close is close enough.

This is performed by ignoring any event that occurs to the same file until the specified time interval has elapsed.

Note that the current debouncing logic may fail to report certain changes to a file, potentially leaving your program in a state that is not consistent with the filesystem.

Make sure that if you are using this feature, all changes you make as a result of an Event notification are both non-essential and idempotent.




> type Action = Event -> IO () 

An action to be performed in response to an event.



> type ActionPredicate = Event -> Bool 

A predicate used to determine whether to act on an event.





> watchDir
>   :: WatchManager -> FilePath -> ActionPredicate -> Action -> IO StopListening


watchDirChan :: WatchManager -> FilePath -> ActionPredicate -> EventChannel -> IO StopListening


watchTree :: WatchManager -> FilePath -> ActionPredicate -> Action -> IO StopListening



-}