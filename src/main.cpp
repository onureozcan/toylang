
#include <ast/ast.h>
#include <compiler/x64.h>

using namespace std;
using namespace toylang;

int main(int argc, char* argv[]) {
    
    string fileName = argv[1];
    
    ofstream outFile;
    outFile.open (fileName + ".asm");

    Ast ast = Ast::fromFile(fileName);
    ast.isMain = true;
    string asmCode = x64Compiler::compile(ast);

    outFile << asmCode;
    outFile.close();

    return 0;
}
