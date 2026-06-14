% Base database facts (Make sure these are present)
child(john,sue).   child(john,sam).
child(jane,sue).   child(jane,sam).
child(sue,george).   child(sue,gina).

male(john).   male(sam).     male(george).
female(sue).  female(jane).   female(june).

parent(Y,X) :- child(X,Y).
father(Y,X) :- child(X,Y), male(Y).
opp_sex(X,Y) :- male(X), female(Y).
opp_sex(Y,X) :- male(X), female(Y).
grand_father(X,Z) :- father(X,Y), parent(Y,Z).
daughter(D,P):- female(D),child(D,P).
mother(M,C):- parent(M,C),female(M).

person(P):- child(P, _).
person(P):- child(_ ,P).

% Your assignment code targets
sibling(S1,S2) :- parent(P, S1), parent(P, S2), S1 \= S2.

gendered(X) :- male(X).
gendered(X) :- female(X).

all_gendered :- \+ (person(X), \+ gendered(X)).

gender_but_not_person(X) :- gendered(X), \+ person(X).