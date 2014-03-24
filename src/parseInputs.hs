-- Parse user commands

module ParseInputs
  ( parseCommand
  , Command (Use, Exit)
  ) where

import Data.Char (toLower)
import Data.Maybe (fromJust,isNothing)
import Text.Regex.TDFA ((=~))

-- Data types
data Command =
  Use { useItem :: String
      , useTarget :: Maybe String} |
  Exit
  deriving (Show)

commands = [("use","^ *use +([a-zA-Z]+)( +on +([a-zA-Z]+))? *$")]

strip char = dropWhile (== char)

makeUseCommand :: String -> Maybe Command
makeUseCommand fullCommand = 
  if isNothing item
    then Nothing
    else Just $ Use (fromJust item) target
    where
    pat = fromJust $ lookup "use" commands
    (_,_,_,matchGroups) = fullCommand =~ pat :: (String,String,String,[String])
    item = if (length matchGroups > 0)
            then Just $ matchGroups !! 0
            else Nothing
    target = if (matchGroups !! 2 /= "")
              then Just $ matchGroups !! 2
              else Nothing

parseCommand :: String -> Maybe Command
parseCommand fullCommand
  | primaryCommand == "use" = makeUseCommand fullCommand
  | primaryCommand == "exit" = Just Exit
  | otherwise = Nothing
    where
    primaryCommand = (map toLower) $ takeWhile (/=' ') $ strip ' ' fullCommand