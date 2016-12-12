Nonterminals instructions instruction.
Terminals value bot output high low n ins_end.
Rootsymbol instructions.

instructions -> instruction instructions : ['$1'|'$2'].
instructions -> instruction : ['$1'].

instruction ->
  value n bot n ins_end : [{value, get_value('$2')}, {to, bot_name('$4')}].
instruction ->
  bot n low bot n high bot n ins_end : [{bot, bot_name('$2')},
                                        {instruction, [{low, bot_name('$5')},
                                          {high, bot_name('$8')}]}].
instruction ->
  bot n low output n high bot n ins_end : [{bot, bot_name('$2')},
                                           {instruction, [{low, {output, get_value('$5')}},
                                             {high, bot_name('$8')}]}].
instruction ->
  bot n low output n high output n ins_end : [{bot, bot_name('$2')},
                                              {instruction, [{low, {output, get_value('$5')}},
                                                {high, output_name('$8')}]}].

Erlang code.

get_value({n, Int}) -> Int.
bot_name({n, Int}) -> list_to_atom("bot_" ++ integer_to_list(Int)).
output_name({n, Int}) -> list_to_atom("output_" ++ integer_to_list(Int)).
