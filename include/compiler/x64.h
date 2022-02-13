#pragma once

#include <ast/ast.h>

using namespace std;

namespace toylang {
    class x64Compiler {

        public:
            static string compile(Ast ast);
    };
} 
