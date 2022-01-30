build: antlr_a

antlr_o:
	test -f build/antlr_static.a || \
	(cd lib/antlr/runtime/Cpp; \
  	g++ -c -std=c++17 \
  -I runtime/src \
  -I runtime/src/atn \
  -I runtime/src/dfa \
  -I runtime/src/misc \
  -I runtime/src/support \
  -I runtime/src/tree \
  -I runtime/src/tree/pattern \
  -I runtime/src/tree/xpath \
   runtime/src/*.cpp \
   runtime/src/atn/*.cpp \
   runtime/src/dfa/*.cpp \
   runtime/src/misc/*.cpp \
   runtime/src/support/*.cpp \
   runtime/src/tree/*.cpp \
   runtime/src/tree/pattern/*.cpp \
   runtime/src/tree/xpath/*.cpp) 

antlr_a: antlr_o
	test -f build/antlr_static.a || (ar rcs build/antlr_static.a lib/antlr/runtime/Cpp/*.o)

clean:
	rm build/*