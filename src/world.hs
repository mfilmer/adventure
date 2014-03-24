module World
  ( Room (Room)
  , RoomType (RoomRoom, RoomHall)
  , Door (Door)
  , Stair (Stair)
  , Item (Item)
  , KeyID (KeyID)
  , World
  , RID
  , Inventory)
  where

data Room = Room RID RoomType Inventory [Door] [Stair]
data RoomType = RoomRoom | RoomHall deriving (Show, Eq)
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

newtype KeyID = KeyID Int
            deriving (Show, Eq)

type World = [Room]
type RID = Int
type Inventory = [Item]


