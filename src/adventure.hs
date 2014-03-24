-- A text based adventure game

import Data.List (splitAt)
import Data.Maybe (fromMaybe)

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

gameLoop = do
  gameLoop