#include <compiler/x64.h>
#include <ast/ast.h>

namespace toylang {

    string x64Compiler::compile(Ast ast) {
        return ast.rootFnc->name + ":\n" + "ret";
    }
}