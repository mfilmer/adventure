{-# LANGUAGE DeriveDataTypeable #-}

module LoadStrings
	( getStrings
  , Strings (Strings)
  , sPrompt
  , sMessages
  , sColors
  ) where

import Text.JSON
import Text.JSON.Generic

data Strings = Strings { sPrompt :: String
                       , sMessages :: [(String,String)]
                       , sColors :: [String]}
                deriving (Eq,Show,Data,Typeable)

getStrings = do
	json <- readFile "strings.json"
	let jsonData = decodeJSON json :: Strings
	return jsonData
