#include "antlr4-runtime.h"

using namespace std;

int main() {
    return 0;
}

static string readFile(const string &fileName) {
    ifstream t(fileName);
    stringstream buffer;
    buffer << t.rdbuf();
    return buffer.str();
}