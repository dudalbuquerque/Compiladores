use antlr4_runtime::{CommonTokenStream, InputStream};

use mini_sql::mini_sql_lexer::MiniSqlLexer;
use mini_sql::mini_sql_parser::MiniSqlParser;

fn parse(input: &str) -> bool {
    let input = InputStream::new(input);
    let lexer = MiniSqlLexer::new(input);
    let tokens = CommonTokenStream::new(lexer);
    let mut parser = MiniSqlParser::new(tokens);

    parser.program().is_ok()
}

#[test]
fn test_select_all() {
    assert!(parse("SELECT * FROM users;"));
}

#[test]
fn test_select_columns() {
    assert!(parse("SELECT name, age FROM users;"));
}

#[test]
fn test_select_with_where() {
    assert!(parse("SELECT name FROM users WHERE age > 18;"));
}

#[test]
fn test_select_with_and() {
    assert!(parse(
        "SELECT name FROM users WHERE age > 18 AND active = TRUE;"
    ));
}

#[test]
fn test_select_with_or() {
    assert!(parse(
        "SELECT name FROM users WHERE age > 18 OR active = TRUE;"
    ));
}

#[test]
fn test_select_with_in() {
    assert!(parse(
        "SELECT name FROM users WHERE age IN (18, 20, 22);"
    ));
}


