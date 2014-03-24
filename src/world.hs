module World
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
  where

data Room = Room RID Inventory [Door] [Stair] | Hall RID Inventory [Door] [Stair]
data DoorType = ExitDoor | RustyDoor | StrongDoor | WoodenDoor
            deriving (Show, Eq)
data DoorStatus = DoorLocked | DoorUnlocked | DoorOpen
            deriving (Show, Eq, Enum, Ord)
data Door = Door (RID,RID) DoorType DoorStatus KeyID
            deriving (Show, Eq)
data Stair = Stair (RID,RID)
            deriving (Show, Eq)

data ItemType = Key KeyID | OtherItem {itemDesc :: String}

data Item = Item { itemName :: String
                 , itemType :: ItemType
                 , itemWeight :: Int
                 , itemAttributes :: [(String,String)]}

type KeyID = Int

type World = [Room]
type RID = Int
type Inventory = [Item]


