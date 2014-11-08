:-[utils],
  [tui],
  [ai].

board(B):-
        create_matrix(5,5,1,B).

/*player([[x,y],[score,name,symbol,stac]])*/
player1([[0,0],[0,'Player 1','*','$']]).
player2([[X,Y],[0,'Player 2','+','&']],X,Y).

start:- create_matrix(4,4,1,B),player1(P1),player2(P2,3,3),print_board(B,P1,P2,4).

/*move_no_stac(player,delta x,delta y,result)*/
move_no_stac([[Px,Py],P],X,Y,[[Px+X,Py+Y],P]).

/*move_stac(player,oponent,delta x,delta y,board,result player, result board)*/