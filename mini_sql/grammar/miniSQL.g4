grammar miniSQL;

program : query+ EOF;


// para teste
query : SELECT WHERE FROM ;

// tokens
SELECT : 'SELECT' ;
WHERE : 'WHERE' ;
FROM : 'FROM' ;


NEWLINE : [\r\n]+ -> skip ;
Int : '-'? DIGIT+ ;
Float : '-'? DIGIT+ '.' DIGIT+ ;
String : '"' ~["]* '"' ;
Boolean : 'TRUE' | 'FALSE' ;


// Um fragment não gera um token sozinho. Ele serve como um pedaço reutilizável para construir outros tokens.
fragment DIGIT : [0-9] ;

// ~ == negação
COMMENT : '--' ~[\r\n]* -> skip ;