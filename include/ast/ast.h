#pragma once

#include <ast/fnc.h>

#include "antlr4-runtime.h"

using namespace std;

namespace toylang {

    class Ast {

        public:
        FncAst* rootFnc;
        bool isMain;

        static Ast fromFile(string fileName);
    };
}