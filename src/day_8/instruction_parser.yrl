Nonterminals instructions instruction.
Terminals rect rot row col n '=' x y inst_end.
Rootsymbol instructions.

instructions -> instruction instructions : ['$1'|'$2'].
instructions -> instruction : ['$1'].

instruction -> rect n x n inst_end : {rect, {to_int('$2'), to_int('$4')}}.
instruction ->
  rot row y '=' n n inst_end : {rot, {row, to_int('$5')}, to_int('$6')}.
instruction ->
  rot col x '=' n n inst_end : {rot, {col, to_int('$5')}, to_int('$6')}.

Erlang code.

to_int({_Token, Char}) -> erlang:list_to_integer(Char).
