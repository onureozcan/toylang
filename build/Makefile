BUILD_DIR = $(shell pwd)
PROJECT_DIR = $(BUILD_DIR)/..
SRC_DIR = $(PROJECT_DIR)/src
INCLUDE_DIR = $(PROJECT_DIR)/include

ANTLR_SUBMODULE_DIR = $(PROJECT_DIR)/lib/antlr/
ANTLR_CPP_PATH = $(PROJECT_DIR)/lib/antlr/runtime/Cpp
ANTLR_SRC_PATH = $(ANTLR_CPP_PATH)/runtime/src

ANTLR_STATIC_LIB_NAME = antlr_static
ANTLR_STATIC_LIB = $(BUILD_DIR)/lib$(ANTLR_STATIC_LIB_NAME).a
ANTLR_OBJECTS_DIR = $(BUILD_DIR)/antlr.a

ANTLR_JAR = antlr-4.9.2-complete.jar
ANTLR_JAR_PATH = $(BUILD_DIR)/$(ANTLR_JAR)

ANTLR_GENERATED_SRC_PATH = $(SRC_DIR)/generated/antlr

EXECUTABLE = $(BUILD_DIR)/toylang

CPP_FLAGS = -std=c++11 -DANTLR4CPP_STATIC

SRCS:=$(shell find $(SRC_DIR)/. -name *.cpp)

build: build_dir libantlr_static.a $(EXECUTABLE) 

build_dir:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(ANTLR_OBJECTS_DIR)

$(ANTLR_JAR):
	wget https://www.antlr.org/download/$(ANTLR_JAR) -O $(ANTLR_JAR)

antlr_generate_sources: $(ANTLR_JAR) $(SRC_DIR)/TLexer.g4 $(SRC_DIR)/TParser.g4
	chmod +x $(ANTLR_JAR_PATH)
	mkdir -p $(ANTLR_GENERATED_SRC_PATH)
	rm -rf $(ANTLR_GENERATED_SRC_PATH)/*
	java -jar $(ANTLR_JAR_PATH) -Dlanguage=Cpp $(SRC_DIR)/TLexer.g4 $(SRC_DIR)/TParser.g4 -o $(ANTLR_GENERATED_SRC_PATH)
	touch antlr_generate_sources

build_antlr_generated: antlr_generate_sources 
	cd $(BUILD_DIR) && \
	g++ -c $(CPP_FLAGS) \
	-I $(ANTLR_GENERATED_SRC_PATH) \
	-I $(ANTLR_SRC_PATH) \
	$(ANTLR_GENERATED_SRC_PATH)/*.cpp 
	touch build_antlr_generated

$(EXECUTABLE): build_antlr_generated $(shell find $(SRC_DIR) -type f) $(shell find $(INCLUDE_DIR) -type f)
	cd $(BUILD_DIR) && \
	g++ $(CPP_FLAGS) \
	-I $(INCLUDE_DIR) \
	-I $(ANTLR_SRC_PATH) \
	-L $(BUILD_DIR) \
	-l $(ANTLR_STATIC_LIB_NAME) \
	$(SRCS) \
	-o $(EXECUTABLE)

libantlr_static.a:
	(cd $(ANTLR_SUBMODULE_DIR) && git reset --hard 4dfacf63e228d616232df90e4273e608d69a7f44 && \
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
	ar rcs $(ANTLR_STATIC_LIB) $(ANTLR_OBJECTS_DIR)/*.o

clean:
	find . ! -name 'Makefile' -type f -exec rm -f {} +

