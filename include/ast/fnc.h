#pragma once

#include "TParser.h"

#include <ast/base.h>

using namespace std;

namespace toylang {

    class FncAst: public BaseAst {

        public:
            FncAst(string fileName, Token* token) : BaseAst(fileName, token) {};
            string name;
            vector<BaseAst> statements;

            static FncAst* from(TParser::ProgramContext* program, string fileName);
    };
} 