PROJECT_DIR = $(shell pwd)
SRC_DIR = $(PROJECT_DIR)/src
INCLUDE_DIR = $(PROJECT_DIR)/include
BUILD_DIR = $(PROJECT_DIR)/build

ANTLR_SUBMODULE_DIR = $(PROJECT_DIR)/lib/antlr/
ANTLR_CPP_PATH = $(PROJECT_DIR)/lib/antlr/runtime/Cpp
ANTLR_SRC_PATH = $(ANTLR_CPP_PATH)/runtime/src

ANTLR_STATIC_LIB = $(BUILD_DIR)/antlr_static.a
ANTLR_OBJECTS_DIR = $(BUILD_DIR)/antlr.a

ANTLR_JAR = antlr-4.9.2-complete.jar
ANTLR_JAR_PATH = $(PROJECT_DIR)/$(ANTLR_JAR)

ANTLR_GENERATED_SRC_PATH = $(SRC_DIR)/generated/antlr

EXECUTABLE = $(BUILD_DIR)/toylang

CPP_FLAGS = -std=c++11 -DANTLR4CPP_STATIC

build: build_dir antlr.a main

build_dir:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(ANTLR_OBJECTS_DIR)

antlr_jar:
	test -f $(ANTLR_JAR_PATH) || (wget https://www.antlr.org/download/$(ANTLR_JAR))

antlr_generate: $(SRC_DIR)/TLexer.g4 $(SRC_DIR)/TParser.g4 antlr_jar
	chmod +x $(ANTLR_JAR_PATH)
	mkdir -p $(ANTLR_GENERATED_SRC_PATH)
	rm -rf $(ANTLR_GENERATED_SRC_PATH)/*
	java -jar $(ANTLR_JAR_PATH) -Dlanguage=Cpp $(SRC_DIR)/TLexer.g4 $(SRC_DIR)/TParser.g4 -o $(ANTLR_GENERATED_SRC_PATH)

antlr_generated.o: antlr_generate
	g++ $(CPP_FLAGS) \
	-I $(ANTLR_GENERATED_SRC_PATH) \
	-I $(ANTLR_SRC_PATH) \
	$(ANTLR_GENERATED_SRC_PATH)/*.cpp \
	-o $(BUILD_DIR)/antlr_generated.o

main: antlr_generated.o $(SRC_DIR)/main.cpp
	g++ $(CPP_FLAGS) \
	-I $(INCLUDE_DIR) \
	-I $(ANTLR_SRC_PATH) \
	src/main.cpp \
	-L $(ANTLR_STATIC_LIB) -o $(EXECUTABLE)
	
antlr.o:
	test -f $(ANTLR_STATIC_LIB) || \
	(cd $(ANTLR_SUBMODULE_DIR) && git checkout 4dfacf63e228d616232df90e4273e608d69a7f44 && \
	cd $(ANTLR_OBJECTS_DIR); \
  	g++ -c $(CPP_FLAGS) \
  -I $(ANTLR_SRC_PATH) \
  -I $(ANTLR_SRC_PATH)/atn \
  -I $(ANTLR_SRC_PATH)/dfa \
  -I $(ANTLR_SRC_PATH)/misc \
  -I $(ANTLR_SRC_PATH)/support \
  -I $(ANTLR_SRC_PATH)/tree \
  -I $(ANTLR_SRC_PATH)/tree/pattern \
  -I $(ANTLR_SRC_PATH)/tree/xpath \
   $(ANTLR_SRC_PATH)/*.cpp \
   $(ANTLR_SRC_PATH)/atn/*.cpp \
   $(ANTLR_SRC_PATH)/dfa/*.cpp \
   $(ANTLR_SRC_PATH)/misc/*.cpp \
   $(ANTLR_SRC_PATH)/support/*.cpp \
   $(ANTLR_SRC_PATH)/tree/*.cpp \
   $(ANTLR_SRC_PATH)/tree/pattern/*.cpp \
   $(ANTLR_SRC_PATH)/tree/xpath/*.cpp) 

antlr.a: antlr.o
	test -f $(ANTLR_STATIC_LIB) || (ar rcs $(ANTLR_STATIC_LIB) $(ANTLR_OBJECTS_DIR)/*.o)

clean:
	rm -rf $(BUILD_DIR)/*