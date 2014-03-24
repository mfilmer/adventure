module GenerateWorld
  where

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

addRoom world = undefined

generateWorld =
  startingRoom
  where
  exitDoor = Door (0, 0) ExitDoor DoorLocked 0
  exitKey = Item "Mysterious Box" (Key 0) 0 []
  startingRoom = Room 0 [exitKey] [exitDoor] []
