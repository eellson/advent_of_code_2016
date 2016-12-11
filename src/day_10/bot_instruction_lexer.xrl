Definitions.

Rules.

value : {token, {value, TokenLine}}.
bot : {token, {bot, TokenLine}}.
output : {token, {output, TokenLine}}.
high : {token, {high, TokenLine}}.
low : {token, {low, TokenLine}}.
[0-9]+ : {token, {n, to_int(TokenChars)}}.
\n : {token, {ins_end, TokenLine}}.
\s : skip_token.
goes : skip_token.
gives : skip_token.
to : skip_token.
and : skip_token.
bot : skip_token.

Erlang code.

to_int(String) ->
  {Int, _} = string:to_integer(String),
  Int.
