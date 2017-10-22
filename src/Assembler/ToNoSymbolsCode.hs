module Assembler.ToNoSymbolsCode
 (toNoSymbolsCode)
 where

import Assembler.SymbolTable
import Assembler.RemoveSymbols

toNoSymbolsCode :: String -> String
-- replaces all symbols with addresses
toNoSymbolsCode concisecode = 
 removeSymbols (symbolTable concisecode) concisecode
