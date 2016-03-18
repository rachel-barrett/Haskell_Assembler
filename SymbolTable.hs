module SymbolTable
 (symbolTable)
 where

symbolTable :: String -> [(String,Int)]
-- a list of all the predefined symbols and label symbols
symbolTable concisecode = predefinedSymbols ++ labelSymbols concisecode

predefinedSymbols :: [(String,Int)]
predefinedSymbols = [("SP",0),("LCL",1),("ARG",2),("THIS",3),("THAT",4),("SCREEN",16384),("KBD",24576)]++[("R" ++ show i,i)| i <- [0..15]]

labelSymbols :: String -> [(String,Int)]
labelSymbols concisecode = let (a,b,c) = while cond step (0, lines concisecode, []) in c

while :: (a -> Bool) -> (a -> a) -> (a -> a)
while cond step = recursion where
 recursion x = if cond x then recursion (step x) else x

cond :: (Int, [String],[(String,Int)]) -> Bool
cond (n,xs,ls) = (xs /= [])

step :: (Int, [String],[(String,Int)]) -> (Int, [String],[(String,Int)])
step (n, x:xs ,ls) = if x !! 0 =='(' then (n, xs, ((tail.init) x, n): ls) else (n+1,xs,ls)

{- Don't have a function for variableSymbols because its better to do that at the same time as replacing the symbols -}