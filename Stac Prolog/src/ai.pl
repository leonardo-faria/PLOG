%TODO greedy move generator

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