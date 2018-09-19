{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE DuplicateRecordFields #-}

--------------------------------------------------

{-|


-}

module Dictation.Server.CLI where

--------------------------------------------------
--------------------------------------------------

--import Dictation.Server.CLI.Types

--------------------------------------------------

import qualified "optparse-applicative" Options.Applicative as P

--------------------------------------------------

import Prelude_dictation_server

--------------------------------------------------
--------------------------------------------------

data Options = Options

  { host      :: String
  , port      :: Maybe Int
  , file      :: Maybe FilePath
  , verbose   :: Bool
  }

--------------------------------------------------

defaultNatlinkServerHostCompletions :: [String]
defaultNatlinkServerHostCompletions = [ "localhost" ]

defaultNatlinkServerPort :: Int
defaultNatlinkServerPort = 3333

defaultNatlinkServerPortCompletions :: [String]
defaultNatlinkServerPortCompletions = (enumFromThenTo defaultNatlinkServerPort 1 7) <&> show

--------------------------------------------------
-- the OptionParser

pOptions :: P.Parser Options
pOptions = Options

  <$> (P.strOption
        ( P.short        'h'
       <> P.long         "host"
       <> P.metavar      "HOST"
       <> P.value        "localhost"
       <> P.completeWith defaultNatlinkServerHostCompletions
       <> P.help         "The server's host address; a String."))
  
  <*> (P.option P.auto
        ( P.short        'p'
       <> P.long         "port"
       <> P.metavar      "PORT"
       <> P.value        (Just defaultNatlinkServerPort)
       <> P.completeWith defaultNatlinkServerPortCompletions
       <> P.help         "The server's port number; an Int. PORT can be empty, which means: choose a random port number that is open, from the operating system's suggestion. between {1024..65535} (ports 49151+ are non-ICANN, and suggested for 'custom' servers)."))

  <*> (P.option (optional P.str)
        ( P.short        'f'
       <> P.long         "file"
       <> P.metavar      "FILEPATH"
       <> P.value        Nothing  --TODO don't fail at missing required arguments if file was given, check it first.
       <> P.action       "file"
       <> P.help         "Read CLI options from FILEPATH (instead of passing them in the shell); a FilePath (to a YAML config). Passed options passed override those written. All (other) options have a namesake in the config file."))

  <*> (P.switch
        ( P.long       "verbose"
       <> P.short      'v'
       <> P.help       "Whether information is logged verbosely."))

---optparse-applicative-flag

--------------------------------------------------

pCLI :: P.ParserInfo Options
pCLI =
  P.info (pOptions <**> P.helper)
    ( P.fullDesc
   <> P.progDesc "Print a greeting for TARGET"
   <> P.header "hello - a test for optparse-applicative")

-- pOptionsAndHelp :: P.Parser Options

--------------------------------------------------
-- the CLI

main :: IO ()
main = do
  options <- P.execParser pCLI
  cli options

cli :: Options -> IO ()
cli Options{..} = do
 print host
 print port
 print file
 print verbose

--------------------------------------------------