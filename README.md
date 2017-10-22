# Nand2Tetris Assembler
This is an assembler I made as part of the online course [Nand2Tetris](http://nand2tetris.org/) (chapter 6).

The program translates Hack assembly code (.asm files) into binary code understood by the Hack hardware platform (.hack files).

Included in the tests folder are example .asm files and their corresponding correct translations into .hack files, with which to test the program against.

To smoke test the program, (assuming you have Haskell installed) run in your bash terminal:

``` bash
$ git clone https://github.com/rachel-barrett/nand2tetris-assembler.git
$ cd nand2tetris-assembler/src
$ runhaskell Main.hs ../tests/assembly/Add.asm # running program
$ cd ../tests
$ diff ./assembly/Add.hack ./binary/Add.hack # observe there are no differences
$ rm ./assembly/Add.hack # cleanup
```

