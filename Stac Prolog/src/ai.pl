
:-use_module(library(random)).

ai_random_move(X,0,S,R,_):-
        random(0,2,T),
        T < 1,
        random(0,2,S),
        Max is round(R / 2),
        M is Max * (-1),
        random(M,Max,X).


ai_random_move(0,Y,S,_,C):-
        Max is round(C / 2),
        M is Max * (-1),
        random(0,2,S),
        random(M,Max,Y).

get_target_pos(B,X,Y,Dx,Dy,Target,[Rx,Ry]):-
        get_matrix(B,X,Y,E),
        (
           E = Target,
           Rx is X,
           Ry is Y;
           X1 is X + Dx,
           Y1 is Y + Dy,
           get_target_pos(B,X1,Y1,Dx,Dy,Target,[Rx,Ry])
        )
        .



make_list_targ(N1,0,_,B,Targ,S,[[N1,0,S]]):-
        get_matrix(B,N1,0,Targ).
make_list_targ(_,0,_,_,_,_,[]).
make_list_targ(N1,N2,L,B,Targ,S,[[N1,N2,S]|T]):-
        get_matrix(B,N1,N2,Targ),
        N is N2 - 1,
        make_list_targ(N1, N,L,B,Targ,S, T).
make_list_targ(N1,N2,L,B,Targ,S,T):-
        N is N2 - 1,
        make_list_targ(N1, N,B,Targ,S, L, T).

make_mat_targ(0,N2,B,Targ,S,L):-
        make_list_targ(0,N2,N2,B,Targ,S,L).
make_mat_targ(N1,N2,B,Targ,S,M):-
        make_list_targ(N1,N2,N2,B,Targ,S,L),
        N is N1 - 1,
        make_mat_targ(N,N2,B,Targ,S,T), 
        append(L, T, M).
        

make_list(N1,0,_,[[N1,0,0]]).
make_list(N1,N2,L,[[N1,N2,0]|T]):-
        N is N2 - 1,
        make_list(N1, N, L, T).
        
make_mat(0,N2,L):-
        make_list(0,N2,N2,L).
make_mat(N1,N2,M):-
        make_list(N1,N2,N2,L),
        N is N1 - 1,
        make_mat(N,N2,T),
        append(L, T, M).
        

get_possible(B,1,F):-
        make_mat_targ(4,4,B,2,1,M1),
        make_mat_targ(4,4,B,1,1,M2),
        make_mat(4,4,M3),
        append(M1, M2, M),
        append(M,M3,F).
get_possible(B,0,F):-
        make_mat_targ(4,4,B,1,0,M1),
        make_mat(4,4,M2),
        append(M1, M2, F).

treat([],_,_,_,_,_,[]).
treat([[X,Y,S]|T1],Xi,Yi,A,W,B,[[Dx,Dy,S]|T2]):-
        Dx is X - Xi,
        Dy is Y - Yi,
        (Dx = 0;
        Dy = 0),
        validate(A,W,B,[Dx,Dy,S],5,5),
        treat(T1,Xi,Yi,A,W,B, T2).
treat([_|T1],Xi,Yi,A,W,B,T2):-
        treat(T1,Xi,Yi,A,W,B, T2).

ai_greedy_move([[Xi,Yi,_]|_],A,W,B,X,Y,S):-
        (
           get_matrix(B,Xi,Yi,1),
           get_possible(B,1,L)
        ;
           get_possible(B,0,L)
        ),
        treat(L,Xi,Yi,A,W,B,[[X,Y,S]|_]).