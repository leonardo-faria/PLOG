:-[utils],
  [tui],
  [ai].

%:-initialization(main).

/*player([[x,y],[score,name,symbol,stac],Type])
Type 0 -> Player
Type 1 -> Random Computer
Type 2 -> Greedy Computer
*/
  
player1([[0,0],[0,'Player 1','*','$'],1]).
player2([[X,Y],[0,'Player 2','+','&'],1],X,Y).

main:- print_start(R,C),
        create_matrix(R,C,1,B),
        player1(P1),
        player2(P2,R-1,C-1),
        move_stac(P1,B,1,1,RP1,B2),
        print_board(B2,RP1,P2,C).

/*move_no_stac(+player,+delta x,+delta y,-result)*/
move_no_stac([[Px,Py],P],X,Y,[[Px+X,Py+Y],P]).

/*move_stac(+player,+delta x,+delta y,+board,-result player, -result board)*/
move_stac([[Px,Py],[S,N,Sy,St],T],B,X,Y,[[Px+X,Py+Y],[S1,N,Sy,St],T],RB):-
        replace_matrix(B,Px,Py,0,B2),
        get_matrix(B2,Px+X,Py+Y,E),
        E1 is E + 1,
        (E1 < 3 -> replace_matrix(B2,Px+X,Py+Y,E1,RB),P is 0;
         replace_matrix(B2,Px+X,Py+Y,St,RB), P is 1),
        S1 is S + P.

win([_,[4,_,_,_,_]]).

/*move(player,board,move[delta x,delta y, stac?],result player,result board)*/
move(A,B,[X,Y,1],RA,RB):-
        move_stac(A,X,Y,B,RA,RB).
move(A,B,[X,Y,0],RA,B):-
        move_no_stac(A,X,Y,RA).

/*play(+active player,+oponent,+board,-result player,-result board)*/
play(A,W,B):-
        get_move(A,B,M),
        (validate(A,W,B,M) -> move(A,B,M,RA,RB),
                              play(W,RA,RB);
         print_invalid,
         play(A,W,B)).

%TODO ver se sai fora do range
validate([[Ax,Ay],_],[[Wx,Wy],_],_,[X,Y,0]):-
        Fx is Ax + X,
        Fy is Ay + Y,
        Fx >= 0,
        Fy >= 0,
        (Fx =\= Wx;
         Fy =\= Wy).


validate([[Ax,Ay],_],[[Wx,Wy],_],_,[X,Y,1]):-
        Fx is Ax + X,
        Fy is Ay + Y,
        Fx >= 0,
        Fy >= 0,
        (Fx =\= Wx;Fy =\=Wy)
        .

get_move([_,_,0],_,[X,Y,S]):-
        read_move(X,Y,S).
get_move([_,_,1],_,[X,Y,S]):-
        ai_random_move(X,Y,S).
get_move(A,B,[X,Y,S]):-
        ai_greedy_move(A,B,X,Y,S).