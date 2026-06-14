% Base database expected by the grading script
likes(john,pizza).
likes(john,sushi).
likes(mary,sushi).
likes(paul,X) :- likes(john,X).
likes(_,icecream).

% Your added custom assignment rules
likes(john, calzone).
likes(john, cilantro).

dislikes(bob, pizza).