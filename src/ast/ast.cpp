#include "antlr4-runtime.h"
#include "TParser.h"
#include "TLexer.h"

#include <ast/ast.h>
#include <ast/fnc.h>

using namespace std;
using namespace antlr4;

namespace toylang {

    Ast Ast::fromFile(string fileName) {
        Ast ast = Ast();

        ifstream stream;
        stream.open(fileName);

        ANTLRInputStream input(stream);
        TLexer lexer(&input);
        CommonTokenStream tokens(&lexer);
        TParser parser(&tokens);

        FncAst* rootFnc = FncAst::from(parser.program(), fileName);
        ast.rootFnc = rootFnc;

        return ast;
    }
}