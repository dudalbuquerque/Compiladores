use antlr4_runtime::{CommonTokenStream, InputStream};

use mini_sql::mini_sql_lexer::MiniSqlLexer;
use mini_sql::mini_sql_parser::MiniSqlParser;

#[test]
fn test_parser() {
    let input = InputStream::new("SELECT * FROM users;");

    let lexer = MiniSqlLexer::new(input);

    let tokens = CommonTokenStream::new(lexer);

    let mut parser = MiniSqlParser::new(tokens);

    let result = parser.program();

    assert!(result.is_ok());
}