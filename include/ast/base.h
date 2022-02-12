#pragma once

#include "antlr4-runtime.h"

using namespace antlr4;
using namespace std;

namespace toylang {

    class BaseAst {

        public:
            BaseAst(string fileName, Token* start) : fileName(fileName), start(start) {};
            int getPosition();
            int getLine();
            string getFileName();
            
        private:
            Token* start;
            string fileName;

    };

}