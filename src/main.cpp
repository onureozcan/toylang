#include "antlr4-runtime.h"
#include "TParser.h"
#include "TLexer.h"

using namespace std;
using namespace antlr4;

int main(int argc, char* argv[]) {
    
    string fileName = argv[1];
    cout << fileName;
    ifstream stream;
    stream.open(fileName);

    ANTLRInputStream input(stream);
    TLexer lexer(&input);
    CommonTokenStream tokens(&lexer);
    TParser parser(&tokens);
    return 0;
}
