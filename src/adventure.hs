-- A text based adventure game
{-# LANGUAGE DeriveDataTypeable #-}

import Data.List (splitAt)
import Data.Maybe (fromJust)

import qualified LoadStrings as S
import World 
  ( Room (Room)
  , RoomType (RoomRoom, RoomHall)
  , Door (Door)
  , Stair (Stair)
  , Item (Item)
  , World
  , RID
  , Inventory)

----- Data Types -----
data Game = Game World Player
data Player = Player RID Inventory

----- Functions and Such -----
main = do
  strings@(sMessages, sColors) <- S.getStrings
  putStrLn $ fromJust $ lookup "welcome" sMessages

  --world <- generateWorld
  --gameLoop world strings

gameLoop world strings = do
  gameLoop world strings