Definitions.

Rules.

value : {token, {value}}.
bot : {token, {bot}}.
output : {token, {output}}.
high : {token, {high}}.
low : {token, {low}}.
[0-9]+ : {token, {n, to_int(TokenChars)}}.
\n : {token, {ins_end}}.
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
