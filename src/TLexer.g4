lexer grammar TLexer;

BlockComment
    :   '/*' .*? '*/'
        -> skip
    ;

LineComment
    :   '//' ~[\r\n]*
        -> skip
    ;

NEWLINE:
    '\r'? '\n' ->skip
    ;

WS  :
    (' '|'\t')+ ->skip
    ;

SEMICOL: ';';
LPAREN: '(';
RPAREN: ')';
LCURLY: '{';
RCURLY: '}';
COMMA: ',';
EQ: '=';
DOT: '.';
MINUS: '-';
TILDE: '~';
STAR: '*';
DIV: '/';
MOD: '%';
PLUS: '+';
LT: '<';
GT: '>';
LTE: '<=';
GTE: '>=';
AND: '&&';
OR: '||';
CMP_EQ: '==';
CMP_NE: '!=';
EX: '!';
DOUBLE_DOT: ':';

VAR: 'var';
FUN: 'fun';
CLASS: 'class';
RET: 'return';
FALSE_: 'false';
TRUE_: 'true';
NULL_: 'null';
IF  : 'if';
ELSE: 'else';
FOR: 'for';
BREAK: 'break';
CONTINUE: 'continue';

INT             : '0'|[1-9][0-9]* ;
DECIMAL         : [0-9][0-9]* '.' [0-9]+ ;
STRING
    : '"' SCharSequence? '"'
    ;

fragment
SCharSequence
    :   SChar+
    ;

fragment
SChar
    :   ~["\\\r\n]
    |   EscapeSequence
    |   '\n'   // Added line
    |   '\r\n' // Added line
;
fragment
EscapeSequence
    :   '\\' ['"?abfnrtv\\]
;

IDENT                 : [_]*[A-Za-z0-9_]+ ;