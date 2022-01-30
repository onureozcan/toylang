PROJECT_DIR = $(shell pwd)

ANTLR_CPP_PATH = $(PROJECT_DIR)/lib/antlr/runtime/Cpp
ANTLR_SRC_PATH = $(ANTLR_CPP_PATH)/runtime/src

BUILD_DIR = $(PROJECT_DIR)/build

ANTLR_STATIC_LIB = $(BUILD_DIR)/antlr_static.a
ANTLR_OBJECTS_DIR = $(BUILD_DIR)/antlr.a

EXECUTABLE = $(BUILD_DIR)/toylang

INCLUDE_DIR = $(PROJECT_DIR)/include

CPP_FLAGS = -std=c++17

build: build_dir main antlr.a

build_dir:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(ANTLR_OBJECTS_DIR)

main: src/main.cpp
	g++ $(CPP_FLAGS) \
	-I $(INCLUDE_DIR) \
	-I $(ANTLR_SRC_PATH) \
	src/main.cpp \
	-L $(ANTLR_STATIC_LIB) -o $(EXECUTABLE)
	
antlr.o:
	test -f $(ANTLR_STATIC_LIB) || \
	(cd $(ANTLR_OBJECTS_DIR); \
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