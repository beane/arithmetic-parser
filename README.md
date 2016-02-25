# Basic Arithmetic Parser
## How to run
`ruby parser.rb '3 / ( 8 - 11 )'` etc. Just make sure there's a space between every token (number, operator, or parenthesis).

## Notes
- parser understands the tokens `+`, `-`, `*`, `/`, `^`, `**`, `(`, and `)`
- all tokens (including parentheses!) must be seperated from all other tokens by whitespace
    - legal: `( 9 + 6 ) ^ 33 - 0`
    - illegal: `(9+6)^33-0`

## Sources
- Shunting-yard algorithm: [link](https://en.wikipedia.org/wiki/Shunting-yard_algorithm)
- RPN evaluation algorithm: [link](https://en.wikipedia.org/wiki/Reverse_Polish_notation)

