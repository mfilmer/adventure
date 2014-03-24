-- A text based adventure game

import Data.List (splitAt)
import Data.Maybe (fromMaybe)

----- Data Types -----
data Game = Game World Player
data Room = Room RID Inventory [Door]
data Player = Player RID Inventory
data Door = N | NE | E | SE | S | SW | W | NW
            deriving (Show, Eq)

data Item = Item { itemName :: String
                 , itemWeight :: Int
                 , itemAttributes :: [(String,String)]}

type World = [Room]
type RID = Int
type Inventory = [Item]

----- Functions and Such -----
-- Read the 'messages.txt' file and parse out the strings
readStrings = do
  fileText <- readFile "messages.txt"
  return $ parseStrs fileText

-- Parse a string of repeating instances of key: "value"
parseStrs fileString = [(key x,value x) | x <- lines fileString]
  where
  key = takeWhile (/=':')
  value x = tail . init $ dropWhile (/='"') (dropWhile (/=':') x)

main = do
  strings <- readStrings
  putStrLn $ fromMaybe "" (lookup "welcome" strings)

  --world <- generateWorld
  --gameLoop world

gameLoop world = do
  gameLoop world