Definitions.

Rules.

rect   : {token, {rect, TokenLine}}.
rotate : {token, {rot, TokenLine}}.
row    : {token, {row, TokenLine}}.
column : {token, {col, TokenLine}}.
[0-9]+ : {token, {n, TokenChars}}.
=      : {token, {'=', TokenLine}}.
x      : {token, {'x', TokenLine}}.
y      : {token, {'y', TokenLine}}.
\n     : {token, {inst_end, TokenLine}}.
by     : skip_token.
\s     : skip_token.

Erlang code.
