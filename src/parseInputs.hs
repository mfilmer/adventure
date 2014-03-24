-- Parse user commands

module ParseInputs
  ( parseCommand
  , Command (Exit,Use,Open,Close,Lock,Unlock)
  ) where

import Data.Char (toLower)
import Data.Maybe (fromJust,isNothing)
import Text.Regex.TDFA ((=~))

-- Data types
data Command =
  Exit | 
  Use { useItem :: String
      , useTarget :: Maybe String} |
  Open { cTarget :: String } |
  Close { cTarget :: String } |
  Lock { cTarget :: String } |
  Unlock { cTarget :: String } |
  Pickup { cTarget :: String} |
  Drop { cTarget :: String } |
  Move { cTarget :: String}
  deriving (Show)

simpleCommand command = "^ *" ++ command ++ " +(the +[a-zA-Z]+|[a-zA-Z]+)$"

commands = [
  ("use","^ *use +(the +[a-zA-Z]+|[a-zA-Z]+)( +on +([a-zA-Z]+|the +[a-zA-Z]+))? *$"),
  ("open", simpleCommand "open"),
  ("close", simpleCommand "close"),
  ("lock", simpleCommand "lock"),
  ("unlock", simpleCommand "unlock"),
  ("pickup", simpleCommand "pickup"),
  ("drop", simpleCommand "drop")
  ]

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