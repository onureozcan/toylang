#include <ast/base.h>

namespace toylang {

    string BaseAst::getFileName() {
        return this->fileName;
    }

    int BaseAst::getLine() {
        return this->start->getLine();
    }

    int BaseAst::getPosition() {
        return this->start->getCharPositionInLine();
    }
}