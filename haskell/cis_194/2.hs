{-# OPTIONS_GHC -Wall #-}
module LogAnalysis where 
import Log

{-toStringList :: String -> [String]-}
{-toStringList str = head (words str) : head (tail (words str)) : [(unwords (tail (tail (words str))))]-}

{-parseMessage :: String -> LogMessage-}
{-parseMessage str = LogMessage (MessageType ((toStringList str) !! 0)) (read ((toStringList str) !! 1)) (toStringList str)-}

parseMessage :: String -> LogMessage
parseMessage x = case words x of
                      ("E":s:t:m) -> LogMessage (Error (read s::Int)) (read t::Int) (unwords m)
                      ("W":t:m) -> LogMessage Warning (read t::Int) (unwords m)
                      ("I":t:m) -> LogMessage Info (read t::Int) (unwords m)
                      _ -> Unknown x

{-parse :: String -> [LogMessage]-}
{-parse str = map parseMessage (lines str)-}
parse = map parseMessage . lines

{-putStrLn $ parseMessage "I 11 Initiating self-destruct sequence"-}
newNode:: LogMessage -> MessageTree
newNode a = Node Leaf a Leaf

-- Warning orphan instance
instance Ord LogMessage where 
  (LogMessage _ ts1 _) `compare` (LogMessage _ ts2 _) = ts1 `compare` ts2
  _ `compare` _ = error "Compare error"

insert :: LogMessage -> MessageTree -> MessageTree
insert (Unknown _) tree = tree
insert message Leaf = newNode message
insert message (Node Leaf node rightChild)
  | message < node = Node (newNode message) node rightChild
insert message (Node leftChild node Leaf)
  | message > node = Node leftChild node (newNode message)
insert message (Node leftChild node rightChild)
  | message < node = Node (insert message leftChild) node rightChild
  | otherwise = Node leftChild node (insert message rightChild) 

build :: [LogMessage] -> MessageTree
build = loop Leaf where 
  loop tree [] = tree
  loop tree msgs = loop (insert (head msgs) tree) (tail msgs)

inOrder:: MessageTree -> [LogMessage]
inOrder = recurse [] where 
  recurse xs Leaf = xs ++ []
  recurse xs (Node left node right) = xs ++ recurse xs left ++ [node] ++ recurse xs right

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong = map messageOf . filter wrong where
  messageOf :: LogMessage -> String
  messageOf (LogMessage _ _ s) = s
  messageOf _ = error "No message, huh?"

  wrong :: LogMessage -> Bool
  wrong (LogMessage (Error s) _ _) = s > 50
  wrong (LogMessage _ s _) = s > 50
  wrong _ = False

msgs :: [LogMessage]
msgs = testParse parse 5523 "error.log"
