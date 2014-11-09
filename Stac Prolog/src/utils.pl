/*create_list(columns,fill,result)*/
create_list(0,_,[]).
create_list(C,F,[F|T]):-
        C1 is C - 1,
        create_list(C1,F,T).

/*create_matrix(rows,columns,fill,result)*/
create_matrix(0,_,_,[]).
create_matrix(R,C,F,[H|T]):-
       create_list(C,F,H),
       R1 is R - 1,
       create_matrix(R1,C,F,T).

/*get_matrix(board,row,columnm,result element)*/
get_matrix([H|_],0,C,E):-
        get(H,C,E).
get_matrix([_|T],R,C,E):-
        R1 is R-1,
        get_matrix(T,R1,C,E).
        
/*get(list,column,result)*/
get([H|_],0,H).
get([_|T],C,E):-
        C1 is C-1,
        get(T,C1,E).
        
/*replace(initial list, column , new element , result).*/
replace([_|T],0,E,[E|T]).
replace([H|T],N,E,[H|L]):-
        N1 is N-1,
        replace(T,N1,E,L).

/*replace_matrix(initial list, row, column , new element , result).*/
replace_matrix([H|T],0,C,E,[L|T]):-
        replace(H,C,E,L).
replace_matrix([H|T],R,C,E,[H|L]):-
        R1 is R-1,
        replace_matrix(T,R1,C,E,L).