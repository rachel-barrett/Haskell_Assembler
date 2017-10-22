module Assembler.ToBinaryCode
 (toBinaryCode)
 where

import Data.Char

toBinaryCode :: String -> String
toBinaryCode = unlines . map sym2bin . filter (\t -> not(take 2 t =="//" || t == "")) . lines . filter (/='\r')

sym2bin :: String -> String
{- program which takes a single line of symbolic machine language and converts it to binary machine language. -}
sym2bin cmd = case toCommandType cmd of
 A_COMMAND -> let a = (address2bin.address) cmd in "0" ++ take (15 - length a ) (repeat '0') ++ a
 C_COMMAND -> "111" ++ (comp2bin.comp) cmd ++ (dest2bin.dest) cmd ++ (jump2bin.jump) cmd

data CommandType = A_COMMAND | C_COMMAND deriving (Show)
type A_COMMAND = String
type C_COMMAND = String

toCommandType :: String -> CommandType
toCommandType command = case command !! 0 of
 '@' -> A_COMMAND
 _   -> C_COMMAND

address :: A_COMMAND -> String
address cmd = tail cmd

dest :: C_COMMAND -> String
dest cmd = if dropWhile (/= '=') cmd == [] 
            then []
            else takeWhile (/= '=') cmd

comp :: C_COMMAND -> String
comp cmd = if dropWhile (/= '=') cmd == [] 
            then takeWhile (/= ';') cmd 
            else tail $ dropWhile (/= '=') $ takeWhile (/= ';') cmd

jump :: C_COMMAND -> String
jump cmd = if dropWhile (/= ';') cmd == []
            then []
            else tail $ dropWhile (/= ';') cmd

address2bin :: String -> String
address2bin x = dec2bin (read x :: Int)

dec2bin :: Int -> [Char]
dec2bin x = snd $ while ((/=0).fst) (\(x,list) -> (x `div` 2, intToDigit (x `mod` 2) : list)) (x, [])

while :: (a -> Bool) -> (a -> a) -> (a -> a)
while cond step = recursion where
 recursion x = if cond x then recursion (step x) else x

dest2bin :: String -> String
dest2bin x = [ if elem 'A' x then '1' else '0', if elem 'D' x then '1' else '0', if elem 'M' x then '1' else '0']

comp2bin :: String -> String
comp2bin x = (if elem 'M' x then '1' else '0') : (snd . head . filter (\(k,v) -> k == map (\y -> if y =='M' then 'A' else y) x) $ [("0","101010"),("1","111111"),("-1","111010"),("D","001100"),("A","110000"),("!D","001101"),("!A","110001"),("-D","001111"),("-A","110011"),("D+1","011111"),("A+1","110111"),("D-1","001110"),("A-1","110010"),("D+A","000010"),("D-A","010011"),("A-D","000111"),("D&A","000000"),("D|A","010101")])

jump2bin :: String -> String
jump2bin x = snd . head . filter (\(k,v) -> k == x) $ [([],"000"),("JGT","001"),("JEQ","010"),("JGE","011"),("JLT","100"),("JNE","101"),("JLE","110"),("JMP","111")]