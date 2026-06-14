% strictlyIncreasing(A,B,C)
strictlyIncreasing(A,B,C) :- A < B, B < C.

% nonDecreasing(A,B,C) 
nonDecreasing(A,B,C) :- A =< B, B =< C.

% quotient_remainder(X,Y,Q,R)
quotient_remainder(X,Y,Q,R) :- Q is X // Y, R is X mod Y. 

% factorial
factorial(0, 1).
factorial(N, F) :- N > 0, N1 is N - 1, factorial(N1, F1), F is N * F1.

% pow(A,P,A_to_the_P)
pow(_, 0, 1).
pow(A, P, Ans) :- P > 0, P1 is P - 1, pow(A, P1, Ans1), Ans is A * Ans1.

% --- MISSING BLOCKS WORLD FACTS ---
loc(b1,0,2).
loc(b2,0,3).
loc(b3,1,0).
loc(b4,1,1).
loc(b5,1,2).
loc(b6,1,3).
loc(b7,2,3).

% blocks world logic
on(Bt,Bb) :- loc(Bt, X, Yt), loc(Bb, X, Yb), Yt is Yb - 1. 
above(Bt,Bb):- loc(Bt, X, Yt), loc(Bb, X, Yb), Yt < Yb. 
left(Bl,Br) :- loc(Bl, Xl, _), loc(Br, Xr, _), Xl < Xr.

% len/2 and sum/2
len([], 0).
len([_|T], N) :- len(T, N1), N is N1 + 1.
 
sum([], 0).
sum([H|T], S) :- sum(T, S1), S is H + S1.

% is_sorted
is_sorted([]).
is_sorted([_]).
is_sorted([H1, H2 | T]) :- H1 =< H2, is_sorted([H2 | T]).

% --- MISSING REVERSE RULE ---
rev([],[]).
rev([H|T], R) :- rev(T, TR), append(TR, [H], R).

% merge/3
merge([], L, L).
merge(L, [], L).
merge([H1|T1], [H2|T2], [H1|M]) :- H1 =< H2, merge(T1, [H2|T2], M).
merge([H1|T1], [H2|T2], [H2|M]) :- H1 > H2, merge([H1|T1], T2, M).

% merge_sort
merge_sort([], []).
merge_sort([X], [X]).
merge_sort(L, S) :- 
    L = [_, _|_], 
    length(L, Len), 
    Half is Len // 2, 
    append(Left, Right, L), 
    length(Left, Half), 
    merge_sort(Left, SLeft), 
    merge_sort(Right, SRight), 
    merge(SLeft, SRight, S).