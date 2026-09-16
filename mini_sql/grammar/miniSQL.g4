grammar MiniSQL;


// () obrigatório
// ()* 0 ou + vezes
// ()? 0 ou 1 vez
// ()+ 1 ou + vezes


// REGRAS DE PARSER

program : query+ EOF;

query : SELECT selectList FROM ID (WHERE condition)? END;


// Permite selecionar múltiplos campos (ex: a, b, c) ou '*'
selectList : ID (',' ID)*
           | '*' ;


// Suporta condições encadeadas por AND / OR (ex: a = 1 AND b > 2)
condition : condition (AND | OR) condition
          | expr ;

expr : left=value op=(EQUAL | NOT_EQUAL | LESS | LESS_EQUAL | GREATER | GREATER_EQUAL) right=value;



//ACHO QUE DESSE JEITO ACEITARIA 1=1 E RETORNARIA TODA, QUEREMOS ? TYPE CHECKER
value: ID
     | INT
     | FLOAT
     | STRING
     | BOOLEAN ;
    


// REGRAS DE LEXER ---> tokens


//palavras chaves
SELECT : 'SELECT' ;
WHERE : 'WHERE' ;
FROM : 'FROM' ;

// types e id
ID : [a-zA-Z_] [a-zA-Z0-9_]* ;  // [] = carcter, pode começar com _
INT : '-'? DIGIT+ ;
FLOAT : '-'? DIGIT+ '.' DIGIT+ ;
STRING : '"' ~["]* '"' ;
BOOLEAN : 'TRUE' | 'FALSE' ;

//operators comparação
EQUAL : '=' ;
NOT_EQUAL : '!=' ;
LESS : '<' ;
LESS_EQUAL : '<=' ;
GREATER : '>' ;
GREATER_EQUAL : '>=' ;

// operadores lógicos
AND : 'AND' ;
OR : 'OR' ;
IN: 'IN' ;



END: ';';
NEWLINE : [\r\n]+ -> skip ;

// fragment
// Um fragment não gera um token sozinho. Ele serve como um pedaço reutilizável para construir outros tokens.
fragment DIGIT : [0-9] ;

// ~ == negação
COMMENT : '--' ~[\r\n]* -> skip ;


// Se começa com maiúscula, é token do Lexer. Se começa com minúscula, é regra do Parser.