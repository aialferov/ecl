-module(ecl).
-export([main/1]).

-define(Usage, "ecl <Command> [Args]~n").

main([]) -> io:format(?Usage);

main([Command|Args]) ->
    io:format(apply(module(Command), run, args(Args))).

module(Command) ->
    list_to_atom(atom_to_list(?MODULE) ++ [$_|Command]).

args(Args) -> lists:map(fun arg/1, Args).
arg(Arg) ->
    {ok, Tokens, _} = erl_scan:string(Arg ++ [$.]),
    {ok, Term} = erl_parse:parse_term(Tokens),
    Term.
