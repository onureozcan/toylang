parser grammar TParser;

options {
	tokenVocab = TLexer;
}

program
        : statement*
        ;

statement:
	expression
        | variableDeclaration
        | emptyStatement
        | ret=RET expression?
        | BREAK
        | CONTINUE
        ;

emptyStatement
        : SEMICOL
        ;

typeDescriptor
        : typeName = IDENT
        ;

typedIdent
        : ident=IDENT (DOUBLE_DOT type=typeDescriptor)?
        ;

variableDeclaration
        : VAR typedIdent (EQ expression)?
        ;

expression
        :primaryExpresssion
       | expression bop=DOT expression
       | expression methodCall=LPAREN (expression (COMMA expression)*)? RPAREN
       | prefix=MINUS expression
       | prefix=(TILDE | EX) expression
       | expression bop=(STAR | DIV | MOD) expression
       | expression bop=(PLUS | MINUS) expression
       | expression bop=(LTE | GTE | GT) expression
       | expression bop=(CMP_EQ | CMP_NE) expression
       | expression bop=EQ expression
       | expression bop=AND expression
       | expression bop=OR expression
       ;

primaryExpresssion
      : LPAREN expression RPAREN
      | atom
      ;

atom: (STRING|INT|DECIMAL|TRUE_|FALSE_|NULL_|IDENT);