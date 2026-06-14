% ================================
% Q1
% ================================
mother(M, C) :- 
    parent(M, C), 
    female(M).

grand_parent(GP, GC) :- 
    parent(GP, P), 
    parent(P, GC).

great_grand_mother(GGM, GGC) :- 
    female(GGM), 
    parent(GGM, GP), 
    grand_parent(GP, GGC).

% ================================
% Q2
% ================================
sibling(A, B) :- 
    parent(P, A), 
    parent(P, B), 
    A \= B.

brother(B, Sib) :- 
    male(B), 
    sibling(B, Sib).

sister(S, Sib) :- 
    female(S), 
    sibling(S, Sib).

% ================================
% Q3
% ================================
% You have to know both parents for both siblings for half_sibling
half_sibling(S1, S2) :-
    parent(Shared, S1), parent(Shared, S2),
    parent(U1, S1), parent(U2, S2),
    Shared \= U1, Shared \= U2, U1 \= U2, 
    S1 \= S2.

full_sibling(S1, S2) :-
    parent(P1, S1), parent(P1, S2),
    parent(P2, S1), parent(P2, S2),
    P1 \= P2, 
    S1 \= S2.

% ================================
% Q4
% ================================
first_cousin(C1, C2) :- 
    parent(P1, C1), 
    parent(P2, C2), 
    sibling(P1, P2), 
    \+ sibling(C1, C2).

second_cousin(C1, C2) :- 
    parent(P1, C1), 
    parent(P2, C2), 
    first_cousin(P1, P2).

% ================================
% Q5
% ================================
half_first_cousin(C1, C2) :- 
    parent(P1, C1), 
    parent(P2, C2), 
    half_sibling(P1, P2).

double_first_cousin(C1, C2) :-
    parent(P1, C1), parent(P2, C2), sibling(P1, P2),
    parent(P3, C1), parent(P4, C2), sibling(P3, P4),
    P1 \= P3, P2 \= P4,
    \+ sibling(C1, C2).

% ================================
% Q6
% ================================
first_cousin_twice_removed(C1, C2) :- 
    grand_parent(GP, C2), 
    first_cousin(C1, GP).

first_cousin_twice_removed(C1, C2) :- 
    grand_parent(GP, C1), 
    first_cousin(C2, GP).

% ================================
% Q7
% ================================
descendant(D, A) :- child(D, A).
descendant(D, A) :- child(D, P), descendant(P, A).

ancestor(A, D) :- parent(A, D).
ancestor(A, D) :- parent(A, C), ancestor(C, D).

% ================================
% Q8
% ================================
% Handles people strictly of the same generational depth from an ancestor.
cousin(X, Y) :- first_cousin(X, Y).
cousin(X, Y) :- parent(Px, X), parent(Py, Y), cousin(Px, Py).

% ================================
% Q9
% ================================
closest_common_ancestor(R1, R2, A) :-
    ancestor(A, R1),
    ancestor(A, R2),
    R1 \= R2,
    \+ (ancestor(Closer, R1), ancestor(Closer, R2), ancestor(A, Closer)).

% ================================
% Q10
% ================================
write_child(X,Y):-
	write(X), write(' is a child of '), write(Y), nl.

% Wrapper ensures failure is caught safely and outputs cleanly
write_descendant_chain(X, Y) :- write_chain_logic(X, Y), !.
write_descendant_chain(_, _) :- true.

% The core recursive looping logic
write_chain_logic(X, Y) :- 
    child(X, Y), 
    write_child(X, Y).

write_chain_logic(X, Y) :- 
    child(X, P), 
    descendant(P, Y), 
    write_child(X, P), 
    write_chain_logic(P, Y).