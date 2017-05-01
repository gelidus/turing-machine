/*
 * FLP - Project Turing Machine
 * @author Peter Malina <xmalin26@stud.fit.vutbr.cz>
 * @description this file implements functinality of the whole
 *      turing machine project
 */

% constructs the tape (last element)
construct_machine([Tape], Tape).
% constructs the machine states
construct_machine([S | T], Tape) :-
    assert_rule(S),
    construct_machine(T, Tape).

% assert_rule creates a new rule from the given line
assert_rule([State, _, Symbol, _, NewState, _, NewSymbol]) :-
    assert(rule(State, Symbol, NewState, NewSymbol)).

% run start the execution of the program
% @param State - current state of the machine
% @param TapeHead - head of the tape
% @param Symbol - current symbol on the tape
% @param TapeTail - rest of the tape
run(State, [TapeHead, Symbol, TapeTail]) :-
    % check if we are in final state
    ( State='F' ->
        write_status(TapeHead, State, Symbol, TapeTail);
        (
            % check if there is a rule that will end the calculation
            rule(State, Symbol, 'F', NewSymbol) ->
                rule(State, Symbol, 'F', NewSymbol);
                rule(State, Symbol, NewState, NewSymbol)
        ),
        write_status(TapeHead, State, Symbol, TapeTail),
        update_tape(NewSymbol, [TapeHead, Symbol, TapeTail], NewTape),
        run(NewState, NewTape)
    ).

% update_tape updates given tape based on the given tape and a symbol
% of a given rule L, R or new symbol
update_tape(NewSymbol, [TapeHead, Symbol, TapeTail], Tape) :-
    (NewSymbol='L' ->
        % move to the left on the tape
        ;
        (NewSymbol='R' ->
            % move to the right
            first(TapeTail, NewTapeSymbol), % get current symbol out of the tape
            append([Symbol], TapeHead, NewTapeHead), % create new tape head
            tail(TapeTail, NewTapeTail),
            construct_tape(NewTapeHead, NewTapeSymbol, NewTapeTail, Tape);
            % change symbol on the tape
            construct_tape(TapeHead, NewSymbol, TapeTail, Tape))
    ).

% construct_tape is a helper that creates a tape from the given symbols
construct_tape(Head, Symbol, Tail, [Head, Symbol, Tail]).

% main is an entry point to the program
main :-
    read_lines(Lines),
    construct_machine(Lines, Tape),
    first(Tape, FirstSymbol),
    tail(Tape, TapeTail),
    % run the turing machine starting on 'S' as a starting State
    run('S', [[], FirstSymbol, TapeTail]).

/* Helpers */

% first is a helper function that returns first element of the list
first([X], X).
first([X|_], X).

% last returns last element of the list
last([], []).
last([X], X).
last([_| T], X) :- last(T, X).

% tail is a wrapper function for [_ | T]
tail([], []).
tail([X], [X]).
tail([_|T], T).

% write_status writes current status of turing machine to the stdout
write_status(Head, State, Symbol, Tail) :-
    write_list(Head), write(State), write(Symbol), write_list(Tail), nl.

% write_list flattens the list and writes it to the stdout
write_list([]).
write_list([H]) :-
    write(H).
write_list([H|T]) :-
    write(H),
    write_list(T).

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