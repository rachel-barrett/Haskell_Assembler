module RemoveSymbols
 (removeSymbols)
 where

import Data.Char

removeSymbols :: [(String,Int)] -> String -> String
removeSymbols table concisecode =
 let (a,b,c,d) = while cond step (16, filter (\t -> t!!0 /='(') (lines concisecode),[],table) 
    in (unlines . reverse) c

while :: (a -> Bool) -> (a -> a) -> (a -> a)
while cond step = recursion where
 recursion x = if cond x then recursion (step x) else x

cond :: (Int, [String], [String], [(String,Int)]) -> Bool
cond (n,xs,ys,ts) = (xs /= [])

step :: (Int, [String], [String], [(String,Int)]) -> (Int, [String], [String], [(String,Int)])
step (n, x:xs, ys , table) = 
 if x !! 0 == '@' && not(isDigit (x !! 1))
  then let a = filter (\(k,v) -> k == tail x) table in 
   if a == [] 
    then (n+1,xs,('@': show n):ys, (tail x, n):table)
    else (n,xs,('@': (show.snd.head) a):ys, table)
  else (n, xs, x:ys, table)
