#[path = "../generated/calc_lexer.rs"]
mod calc_lexer;

#[path = "../generated/calc_parser.rs"]
mod calc_parser;

use antlr4_runtime::char_stream::InputStream;
use antlr4_runtime::token_stream::CommonTokenStream;

use calc_lexer::CalcLexer;
use calc_parser::CalcParser;

fn main() {
    let input = "10 + 20";

    let input_stream = InputStream::new(input);

    let lexer = CalcLexer::new(input_stream);

    let tokens = CommonTokenStream::new(lexer);

    let mut parser = CalcParser::new(tokens);

    let tree = parser.expression();

    println!("{:?}", tree);
}