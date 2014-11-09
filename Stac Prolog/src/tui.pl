%TODO create menus and moves' input

print_scores(P1,P2):-
        print_score(P1),
        nl,
        print_score(P2).

print_score([_,[S,N,_,_],_]):-
        write(N),
        write(' has '),
        write(S),
        write(' points'),
        nl.


print_board(B,P1,P2,L):-
        write('  '),
        print_top(L),
        print_matrix(B,P1,P2,L),
        nl,
        print_scores(P1,P2).

print_matrix([],_,_,_).
print_matrix([H|T],[[X1,Y1],[_,_,S1,_],_],[[X2,Y2],[_,_,S2,_],_],L):-
        nl,
        print_line([X1,Y1,S1],[X2,Y2,S2],L),
        write(' |'),
        nl,
        Xn1 is X1 - 1,
        Xn2 is X2 - 1,
        print_row(H),
        write(' | '),
        nl,
        write(' |'),
        print_bottom(L),
        print_matrix(T,[[Xn1,Y1],[_,_,S1,_],_],[[Xn2,Y2],[_,_,S2,_],_],L).

print_row([]).
print_row([H|T]):-
        write(' | '),
        write(H),
        print_row(T).

print_top(1):-
        write('___').
print_top(N):-
        N1 is N - 1,
        write('____'),
        print_top(N1).

print_bottom(0).
print_bottom(N):-
        N1 is N - 1,
        write('___|'),
        print_bottom(N1).


print_line(_,_,0).
print_line([X1,Y1,S1],[X2,Y2,S2],N):-
        write(' | '),
        print_player([X1,Y1,S1],[X2,Y2,S2]),
        Yn1 is Y1 - 1,
        Yn2 is Y2 - 1,
        N1 is N - 1,
        print_line([X1,Yn1,S1],[X2,Yn2,S2],N1).

print_player([0,0,S],_):-
        write(S).
print_player(_,[0,0,S]):-
        write(S).
print_player(_,_):-
        write(' ').

print_start(R,C):-
        write('Welcome to Stac!\nPlease select board size.\nRows: '),
        get_code(R1),
        get_char(_),
        write('Collumns: '),
        get_code(C1),
        get_char(_),
        R is R1 - 48,
        C is C1 - 48.

print_invalid:-
        write('Invalid move!'),
        nl.