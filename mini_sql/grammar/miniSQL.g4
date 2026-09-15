grammar miniSQL;

// REGRAS DE PARSER
program : query+ EOF;
query : SELECT (ID | '*') FROM ID END;
condition : ;

// REGRAS DE LEXER
SELECT : 'SELECT' ;
WHERE : 'WHERE' ;
FROM : 'FROM' ;

ID : [a-zA-Z] [a-zA-Z0-9_]* ;
END: ';';

NEWLINE : [\r\n]+ -> skip ;

// types
INT : '-'? DIGIT+ ;
FLOAT : '-'? DIGIT+ '.' DIGIT+ ;
STRING : '"' ~["]* '"' ;
BOOLEAN : 'TRUE' | 'FALSE' ;

//operators
EQUAL : '=' ;
NOT_EQUAL : '!=' ;
LESS : '<' ;
LESS_EQUAL : '<=' ;
GREATER : '>' ;
GREATER_EQUAL : '>=' ;

AND : 'AND' ;
OR : 'OR' ;
IN: 'IN' ;


// fragment
// Um fragment não gera um token sozinho. Ele serve como um pedaço reutilizável para construir outros tokens.
fragment DIGIT : [0-9] ;

// ~ == negação
COMMENT : '--' ~[\r\n]* -> skip ;


// Se começa com maiúscula, é token do Lexer. Se começa com minúscula, é regra do Parser.