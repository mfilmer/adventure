module GenerateWorld
  where

import World
  ( Room (Room)
  , RoomType (RoomRoom, RoomHall)
  , Door (Door)
  , Stair (Stair)
  , Item (Item)
  , KeyID (KeyID)
  , World
  , RID
  , Inventory)

addRoom world = undefined

generateWorld = do
  exitDoor = Door (0,0) ExitDoor DoorLocked 0
  exitKey = Item "Mysterious Box" (Key 0) 0 []
  startingRoom = Room 0 RoomRoom [exitDoor] [exitKey]
