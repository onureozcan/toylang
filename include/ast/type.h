#pragma once

#include "TParser.h"

using namespace std;

namespace toylang { 
    
    class TypeAst: public BaseAst {
        
        public:
            TypeAst(string fileName, Token* token) : BaseAst(fileName, token) {};
            string ident;
    };
}