Definitions.

IP_END = \n
HYPE_BEGIN = \[
HYPE_END = \]

Rules.

{HYPE_BEGIN} : {token, {hype_begin, TokenLine}}.
{HYPE_END} : {token, {hype_end, TokenLine}}.
[a-z]+ : {token, {chars, TokenChars}}.
{IP_END} : {token, {ip_end, TokenChars}}.

Erlang code.
