use antlr4_runtime::{CommonTokenStream, InputStream};

use mini_sql::mini_sql_lexer::MiniSqlLexer;
use mini_sql::mini_sql_parser::MiniSqlParser;

fn parse_error(input: &str) -> bool {
    let input = InputStream::new(input);
    let lexer = MiniSqlLexer::new(input);
    let tokens = CommonTokenStream::new(lexer);
    let mut parser = MiniSqlParser::new(tokens);

    parser.program().is_err()
}

#[test]
fn test_missing_select_list() {
    assert!(parse_error("SELECT FROM users;"));
}

#[test]
fn test_missing_select() {
    assert!(parse_error("name FROM users;"));
}

#[test]
fn test_missing_from() {
    assert!(parse_error("SELECT name users;"));
}

#[test]
fn test_missing_where_condition() {
    assert!(parse_error("SELECT name FROM users WHERE;"));
}

#[test]
fn test_typo_in_from() {
    assert!(parse_error(
        "SELECT name form users WHERE age > 18 AND active = TRUE;"
    ));
}

#[test]
fn test_invalid_table_syntax() {
    assert!(parse_error(
        "SELECT name FROM users()_uugf WHERE age > 18 OR active = TRUE;"
    ));
}

#[test]
fn test_typo_in_select() {
    assert!(parse_error("selec * from users;"));
}

#[test]
fn test_identifier_start_with_number() {
    assert!(parse_error("SELECT name FROM 123users;"));
}

#[test]
fn test_invalid_identifier_start() {
    assert!(parse_error("SELECT name FROM _users;"));
}