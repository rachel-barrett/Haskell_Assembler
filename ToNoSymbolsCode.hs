module ToNoSymbolsCode
 (toNoSymbolsCode)
 where

import SymbolTable
import RemoveSymbols

toNoSymbolsCode :: String -> String
-- replaces all symbols with addresses
toNoSymbolsCode concisecode = 
 removeSymbols (symbolTable concisecode) concisecode
