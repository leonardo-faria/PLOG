/*print_scores(+Player1,+Player2)*/
print_scores(P1,P2):-
        print_score(P1),
        nl,
        print_score(P2).

/*print_score(+Player1)*/
print_score([_,[S,N,_,_]|_]):-
        write(N),
        write(' has '),
        write(S),
        write(' points'),
        nl.

/*print_boar(+Board,+Player1,+Player2,+Legth)*/
print_board(B,P1,P2,L):-
        write('  '),
        print_top(L),
        print_matrix(B,P1,P2,L),
        nl,
        print_scores(P1,P2).

/*print_matrix(+Board,+Player1,+Player2,+Legth)*/
print_matrix([],_,_,_).
print_matrix([H|T],[[X1,Y1,_],[_,_,S1,_],_],[[X2,Y2,_],[_,_,S2,_],_],L):-
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
        print_matrix(T,[[Xn1,Y1,_],[_,_,S1,_],_],[[Xn2,Y2,_],[_,_,S2,_],_],L).

/*print_row(+Row)*/
print_row([]).
print_row([H|T]):-
        write(' | '),
        write(H),
        print_row(T).

/*print_top(+N)*/
print_top(1):-
        write('___').
print_top(N):-
        N1 is N - 1,
        write('____'),
        print_top(N1).


/*print_bottom(+N)*/
print_bottom(0).
print_bottom(N):-
        N1 is N - 1,
        write('___|'),
        print_bottom(N1).


/*print_line(+Player1,+Player2,+N)*/
print_line(_,_,0).
print_line([X1,Y1,S1],[X2,Y2,S2],N):-
        write(' | '),
        print_player([X1,Y1,S1],[X2,Y2,S2]),
        Yn1 is Y1 - 1,
        Yn2 is Y2 - 1,
        N1 is N - 1,
        print_line([X1,Yn1,S1],[X2,Yn2,S2],N1).

/*print_player(+Player1,+Player2)*/
print_player([0,0,S],_):-
        write(S).
print_player(_,[0,0,S]):-
        write(S).
print_player(_,_):-
        write(' ').

/*print_start(-Rows,-Columns,+Player1,+Player2)*/
print_start(R,C,P1,P2):-
        write('Welcome to Stac!\nPlease select board size.\nRows: '),
        get_code(R1),
        get_char(_),
        write('Collumns: '),
        get_code(C1),
        get_char(_),
        
        write('Player 1 type (0 human, 1 random ai, 2 "smart" ai): '),
        get_code(T1),
        get_char(_),
        
        write('Player 2 type (0 human, 1 random ai, 2 "smart" ai): '),
        get_code(T2),
        get_char(_),
        
        
        (
           R is R1 - 48,
           C is C1 - 48,
           P1 is T1 - 48,
           P2 is T2 - 48,
           R < 10,R > 0,
           C < 10,C > 0,
           P1 < 3,
           P1 >= 0,
           P2 < 3,
           P2 >= 0
        ;
           print_start(R,C,P1,P2)
        ).
/*print_invalid*/
print_invalid:-
        write('Invalid move!'),
        nl.

/*read_move(+Name,-Dx,-Dy,-Move_stac)*/
read_move(Name,X,Y,S):-
        write('It\'s '),
        write(Name),
        write(' turn!'),
        write('Move stac?(y/n)'),
        get_char(C1),
        get_char(_),
        (
           C1 = 'y',S is 1
        ;
           S is 0
        ),
        write('[U]p, [D]own, [L]eft or [R]ight?'),
        get_char(C2),
        get_char(_),
        write('How many steps?'),
        get_code(C3),
        get_code(_),
        N is C3 - 48,
         (
           C2 == 'U',X is N * (-1),Y is 0
         ;
           C2 == 'R',Y is N, X is 0
         ;
           C2 == 'D',X is N, Y is 0
         ;
           C2 == 'L',Y is N * (-1), X is 0
        ).