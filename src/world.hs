module World
  ( Room (Room)
  , RoomType (RoomRoom, RoomHall)
  , Door (Door)
  , Stair (Stair)
  , Item (Item)
  , World
  , RID
  , Inventory)
  where

data Room = Room RID RoomType Inventory [Door] [Stair]
data RoomType = RoomRoom | RoomHall deriving (Show, Eq)
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


