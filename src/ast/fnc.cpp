#include <ast/fnc.h>

#include "TParser.h"
#include "antlr4-runtime.h"

using namespace std;
using namespace antlr4;

namespace toylang {

    FncAst* FncAst::from(TParser::ProgramContext* program, string fileName) {
        FncAst* fnc = new FncAst(fileName, program->start);
        string label = "";

        for (int i = 0; i < fileName.length(); i++) {
            char c = fileName[i];
            if (c == '/' || c == '.' || c == ' ') { // replace file path things..
                c = '_';
            }
            label += c;
        }

        fnc-> name = label;
        return fnc;
    }
}
