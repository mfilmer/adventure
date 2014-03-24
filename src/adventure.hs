-- A text based adventure game
{-# LANGUAGE DeriveDataTypeable #-}

import Data.List (splitAt)
import Data.Maybe (fromJust)

import qualified loadStrings as S

----- Data Types -----
data Game = Game World Player
data Room = Room RID RoomType Inventory [Door] [Stair]
data RoomType = RoomRoom | RoomHall deriving (Show, Eq)
data Player = Player RID Inventory
data Door = Door (RID,RID)
            deriving (Show, Eq)
data Stair = Stair (RID,RID)
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
  putStrLn $ fromJust $ lookup "welcome" strings

  --world <- generateWorld
  --gameLoop world

gameLoop world = do
  gameLoop world