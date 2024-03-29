#include <compiler/x64.h>
#include <ast/ast.h>

using namespace std;

namespace toylang {

    string x64Compiler::compile(Ast ast) {
        string entryLabel = "";
        if (ast.isMain) {
            entryLabel = "global ty_main\nty_main:\n";
        }

        return entryLabel + ast.rootFnc->name + ":\n" + "ret";
    }
}