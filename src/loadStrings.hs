{-# LANGUAGE DeriveDataTypeable #-}

module LoadStrings
	(getStrings)
	where

import Text.JSON
import Text.JSON.Generic

data Strings = Strings { sMessages :: [(String,String)]
											 , sColors :: [String]}
                deriving (Eq,Show,Data,Typeable)

getStrings = do
	json <- readFile "strings.json"
	let jsonData = decodeJSON json :: Strings
	return ((sMessages jsonData), (sColors jsonData))
