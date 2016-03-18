module Main (main) where

import ToConciseCode -- for `toConciseCode`
import ToNoSymbolsCode -- for `toNoSymbolsCode`
import ToBinaryCode -- for `toBinaryCode`

import System.Environment -- for `getArgs`
import Control.Monad -- for `forM`

main = do
 args <- getArgs
 forM args (\arg -> do
  contents <- readFile arg
  writeFile (((reverse . drop 4 . reverse) arg) ++ ".hack") 
   ((toBinaryCode . toNoSymbolsCode . toConciseCode) contents)
  ) 