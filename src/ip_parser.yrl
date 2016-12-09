Nonterminals ips ip hypernet_seq.
Terminals hype_begin hype_end ip_end chars.
Rootsymbol ips.

ips -> ip : ['$1'].
ips -> ip ips : ['$1'|'$2'].

ip -> hypernet_seq ip : ['$1'|'$2'].
ip -> chars ip : ['$1'|'$2'].
ip -> ip_end : [].

hypernet_seq -> hype_begin chars hype_end : {hype, '$2'}.
