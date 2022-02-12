#include <ast/fnc.h>

#include "TParser.h"
#include "antlr4-runtime.h"

using namespace std;
using namespace antlr4;

namespace toylang {

    FncAst* FncAst::from(TParser::ProgramContext* program, string fileName) {
        FncAst* fnc = new FncAst(fileName, program->start);
        return fnc;
    }
}
