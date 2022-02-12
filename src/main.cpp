
#include <ast/ast.h>
#include <ast/fnc.h>

using namespace std;
using namespace antlr4;
using namespace toylang;

int main(int argc, char* argv[]) {
    
    string fileName = argv[1];
    
    Ast ast = Ast::fromFile(fileName);
    
    return 0;
}
