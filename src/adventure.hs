-- A text based adventure game
{-# LANGUAGE DeriveDataTypeable #-}

import Data.List (splitAt)
import Data.Maybe (fromJust,isNothing,isJust)

import GenerateWorld (generateWorld)
import qualified ParseInputs as P
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
data GameState = GameState World Player
data Player = Player RID Inventory

----- Functions and Such -----
main = do
  strings@(S.Strings _ sMessages _) <- S.getStrings
  putStrLn $ fromJust $ lookup "welcome" sMessages

  -- Set up initial world
  let world = generateWorld
  let player = Player 0 []
  let gameState = GameState world player
  gameLoop world strings

gameLoop world strings = do
  putStr $ S.sPrompt strings
  textCommand <- getLine
  let command = P.parseCommand textCommand
  if (isNothing command)
    then do
      putStrLn $ fromJust (lookup "invalidCommand" sMessages)
      gameLoop world strings
    else do
      let (world', exit) = runCommand world strings (fromJust command)
      if exit
        then putStrLn "The End"
        else gameLoop world' strings
  where
    sMessages = S.sMessages strings

runCommand world (S.Strings _ sMessages _) P.Exit = (world, True)
runCommand world strings command = (world, False)
