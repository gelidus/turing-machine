/*
 * FLP - Project Turing Machine
 * @author Peter Malina <xmalin26@stud.fit.vutbr.cz>
 * @description this file implements functinality of the whole
 *      turing machine project
 */

% read_line reads a single line from the stdin
read_line(L, C) :-
    get_char(C),
    (isEOFEOL(C), L = [], !;
        read_line(LL, _), atom_codes(C, [_]),
        [C|LL] = L
    ).

% isEOFEOL returns true if on the end of line or end of input
isEOFEOL(C) :-
    C == end_of_file;
    (char_code(C, Code), Code == 10).

% read_lines reads all lines from stdin
read_lines(Ls) :-
    read_line(L, C),
    (C == end_of_file, Ls = []; (read_lines(LLs), [L|LLs] = Ls)).

% constructs the tape (last element)
construct_machine([Tape], Tape).
% constructs the machine states
construct_machine([S | T], Tape) :-
    assert_rule(S),
    construct_machine(T, Tape).

% assert_rule creates a new rule from the given line
assert_rule([State, _, Symbol, _, NewState, _, NewSymbol]) :-
    assert(rule(State, Symbol, NewState, NewSymbol)).

main :-
    read_lines(Lines),
    construct_machine(Lines, Tape),
    halt.