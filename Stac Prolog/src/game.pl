
:-use_module(library(between)).
%:-initialization(main).

/*player([[x,y,moved stac],[score,name,symbol,stac],Type])
Type 0 -> Player
Type 1 -> Random Computer
Type 2 -> Greedy Computer
*/
  
player1([[0,0,0],[0,'Player 1','*','$'],T],T).
player2([[X,Y,0],[0,'Player 2','+','&'],T],X,Y,T).
main:-  print_start(R,C,P1T,P2T),
        create_matrix(R,C,1,B),
        player1(P1,P1T),
        R1 is R - 1,
        C1 is C - 1,
        player2(P2,R1,C1,P2T),
        play(P1,P2,B,R,C).

/*move_no_stac(+player,+delta x,+delta y,-result)*/
move_no_stac([[Px,Py,_]|P],X,Y,[[Fx,Fy,0]|P]):-
        Fx is Px + X,
        Fy is Py + Y.

/*move_stac(+player,+board,+delta x,+delta y,-result player, -result board)*/
move_stac([[Px,Py,_],[S,N,Sy,St],T],B,X,Y,[[Fx,Fy,1],[S1,N,Sy,St],T],RB):-
        Fx is Px + X,
        Fy is Py + Y,
        replace_matrix(B,Px,Py,0,B2),
        get_matrix(B2,Fx,Fy,E),
        E1 is E + 1,
        (E1 < 3 -> replace_matrix(B2, Fx,Fy,E1,RB),P is 0;
         replace_matrix(B2, Fx,Fy,St,RB), P is 1),
        S1 is S + P.

win([_,[3,N|_],_]):-
        nl,nl,
        write(N),
        write(' wins!').

/*move(player,board,move[delta x,delta y, stac?],result player,result board)*/
move(A,B,[X,Y,1],RA,RB):-
        move_stac(A,B,X,Y,RA,RB).
move(A,B,[X,Y,0],RA,B):-
        move_no_stac(A,X,Y,RA).

/*play(+active player,+oponent,+board,-result player,-result board)*/
play(A,W,B,R,C):-
        print_board(B,A,W,C),
        get_move(A,W,B,M,R,C),
        !,
        (
           validate(A,W,B,M,R,C),
           move(A,B,M,RA,RB),
           (
              win(A);
              play(W,RA,RB,R,C)
           );
           print_invalid,
           play(A,W,B,R,C)
        ).


/*validate(+active player,+oponent,+board,+move)*/
validate([[Ax,Ay,_]|_],[[Wx,Wy,_]|_],_,[X,Y,0],R,C):-
        (X =\= 0;Y =\= 0),
        Fx is Ax + X,
        Fy is Ay + Y,
        Fx >= 0,
        Fy >= 0,
        Fx < R,
        Fy < C,
        (Fx =\= Wx;
         Fy =\= Wy).


validate([[Ax,Ay,0]|_],[[Wx,Wy,_]|_],B,[X,0,1],R,C):-
        validate([[Ax,Ay,_]|_],[[Wx,Wy,_]|_],B,[X,0,0],R,C),
        get_matrix(B,Ax,Ay,1),
        Fx is Ax + X,
        (get_matrix(B,Fx,Ay,0);get_matrix(B,Fx,Ay,1)),
        (Ay == Wy ->
         (X < 0 -> between(Ax,Fx,Wx),!,false;
          between(Fx,Ax,Wx),!,false);
         true).

validate([[Ax,Ay,0]|_],[[Wx,Wy,_]|_],B,[0,Y,1],R,C):-
        
        validate([[Ax,Ay,_]|_],[[Wx,Wy,_]|_],B,[0,Y,0],R,C),
        get_matrix(B,Ax,Ay,1),
        Fy is Ay + Y,
        (get_matrix(B,Ax,Fy,0);get_matrix(B,Ax,Fy,1);get_matrix(B,Ax,Fy,2)),
        (Ax == Wx ->
         (Y < 0 -> between(Ay,Fy,Wy),!,false;
          between(Fy,Ay,Wy),!,false);
         true).

get_move([_,[_,N|_],0],_,_,[X,Y,S],_,_):-
        read_move(N,X,Y,S).
get_move([_,_,1],_,_,[X,Y,S],R,C):-
        ai_random_move(X,Y,S,R,C).
get_move(A,W,B,[X,Y,S],_,_):-
        ai_greedy_move(A,A,W,B,X,Y,S),nl,
        get_char(_).