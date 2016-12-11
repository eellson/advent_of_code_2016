Nonterminals instructions instruction.
Terminals value bot output high low n ins_end.
Rootsymbol instructions.

instructions -> instruction instructions : ['$1'|'$2'].
instructions -> instruction : ['$1'].

instruction ->
  value n bot n ins_end : {{value, get_value('$2')}, {bot, get_value('$4')}}.
instruction ->
  bot n low bot n high bot n ins_end : {{bot, get_value('$2')}, {bot, get_value('$5')}, {bot, get_value('$8')}}.
instruction ->
  bot n low output n high bot n ins_end : {{bot, get_value('$2')}, {output, get_value('$5')}, {bot, get_value('$8')}}.
instruction ->
  bot n low output n high output n ins_end : {{bot, get_value('$2')}, {output, get_value('$5')}, {output, get_value('$8')}}.

Erlang code.

get_value({n, Int}) -> Int.
