module Assembler.ToConciseCode
 (toConciseCode)
 where

toConciseCode :: String -> String
-- Removes comments and whitespace
toConciseCode = unlines . map (takeWhile (\t-> t /= ' ' && t /= '/') . (dropWhile (==' '))) . filter (\t -> not(take 2 t =="//" || t == "")) . lines . filter (/='\r')