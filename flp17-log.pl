/*
 * FLP - Project Turing Machine
 * @author Peter Malina <xmalin26@stud.fit.vutbr.cz>
 * @description this file implements functinality of the whole
 *      turing machine project
 */

read_line(L, C) :-
    get_char(C),
    (isEOFEOL(C), L = [], !;
        read_line(LL, _), atom_codes(C, [Cd]),
        [C|LL] = L
    ).

isEOFEOL(C) :-
    C == end_of_file;
    (char_code(C, Code), Code == 10).

read_lines(Ls) :-
    read_line(L, C),
    (C == end_of_file, Ls = []; (read_lines(LLs), [L|LLs] = Ls)).

main :-
    Write('Hello World'), halt.