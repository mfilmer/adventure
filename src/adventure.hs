-- A text based adventure game
{-# LANGUAGE DeriveDataTypeable #-}

import Data.List (splitAt)
import Data.Maybe (fromJust)

import GenerateWorld (generateWorld)
import qualified LoadStrings as S
import World 
  ( Room (Room, Hall)
  , Door (Door)
  , DoorType (ExitDoor, RustyDoor, StrongDoor, WoodenDoor)
  , DoorStatus (DoorLocked, DoorUnlocked, DoorOpen)
  , Stair (Stair)
  , Item (Item)
  , ItemType (Key, OtherItem)
  , KeyID
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

  -- Set up initial world
  let world = generateWorld
  gameLoop world strings

gameLoop world strings = do
  gameLoop world strings