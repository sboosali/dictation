
--------------------------------------------------

{-|



-}
module Dictation.Server.Types where

--------------------------------------------------

import Prelude_dictation_server

--------------------------------------------------

--import "spiros" Prelude.Spiros.Classes

--------------------------------------------------



--------------------------------------------------
--------------------------------------------------

{-|

-}

newtype Recognition = Recognition

  [Text]

  deriving stock    (Show,Read,Generic)
  deriving newtype  (Eq,Ord,Semigroup,Monoid)
  deriving newtype  (NFData,Hashable)

instance IsList Recognition where
  type Item Recognition = Text
  fromList = coerce
  toList   = coerce

--------------------------------------------------

{-|

-}

newtype DragonRecognition = DragonRecognition

  [DragonWord]

  deriving stock    (Show,Read,Generic)
  deriving newtype  (Eq,Ord,Semigroup,Monoid)
  deriving newtype  (NFData,Hashable)

instance IsList DragonRecognition where
  type Item DragonRecognition = DragonWord
  fromList = coerce
  toList   = coerce

--------------------------------------------------

{-| 

-}

data DragonWord
 = DragonWord String

  deriving stock    (Show,Read,Eq,Ord,Lift,Generic)
  deriving anyclass (NFData,Hashable)

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
--------------------------------------------------