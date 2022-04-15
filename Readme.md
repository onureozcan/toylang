# Toylang 
#### 3rd attempt to create a toy programming language
planned features:
 - does not create binary files by itself 
 - emits asm code instead 
 - respects platform conventions so that it can be compiled and linked against existing libraries
 - staticly and strongly typed 
 - oop features: objects, inheritence and polymorphism
 - first class functions
 - generic types 
 - managed memory
 - partial types?

see roadmap.md 

#### how to compile
`cd build && make clean build`

this will generate a binary called toylang
*subsequent runs do not need clean

`make test` 
will run the generated binary at the above stage so that toylang creates respecting asm files. then, it will compile them using gcc against the standard lib and the wrapper functions and run

#### codebase structure
`src/`
 - `ast/`: responsible from converting ANTLR-generated parse tree into human friendly abstract syntaxt tree. additional syntaxt errors that may be hard to encode into the grammar may be thrown here
 - `type:/` extracts type information by traversing the generated ast by considering context and language semantic rules. semantic errors are thrown here
 - `compiler/`: generates asm code. if this stage is reached, no errors should be thrown 
 - `wrapper/`: includes needed c code functions that the generated code calls
 - `generated`: this one includes antlr-generated parser and lexer code 
