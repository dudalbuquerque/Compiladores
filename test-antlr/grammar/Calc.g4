grammar Calc;

// ====================
// Parser rules
// ====================

expression
    : NUMBER PLUS NUMBER
    ;

// ====================
// Lexer rules
// ====================

PLUS
    : '+'
    ;

NUMBER
    : [0-9]+
    ;

WS
    : [ \t\r\n]+ -> skip
    ;