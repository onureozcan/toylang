#pragma once

#include <ast/ast.h>
#include <ast/type.h>

#include <type/type.h>

#include "antlr4-runtime.h"

using namespace std;

namespace toylang {

    class ExpressionAst: public BaseAst {
        
        public:
            ExpressionAst(string fileName, Token* token) : BaseAst(fileName, token) {};
            TypeAst* typeAst;
            Type* type;
    };

    class AtomicExpressionAst: public ExpressionAst {

        public:
            AtomicExpressionAst(string fileName, Token* token) : ExpressionAst(fileName, token) {};
            string data;

            static AtomicExpressionAst* from(TParser::AtomContext atom_context, string fileName);
    };

    class BinaryExpressionAst: public ExpressionAst {

        public:
            BinaryExpressionAst(string fileName, Token* token) : ExpressionAst(fileName, token) {};
            ExpressionAst* left;
            ExpressionAst* right;
            string operation;
    };
}