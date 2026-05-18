% =============================================================================
% CSCE 330 - Program 2: Prolog Movie Database Queries
% =============================================================================

% Did Leonardo DiCaprio act in Babel?
q1 :- 
    acted_in('Leonardo DiCaprio', 'Babel').

% Who directed District 9?
q2(D) :- 
    directed(D, 'District 9').

% Did anyone act in Both Click and The Aviator
q3(A) :- 
    acted_in(A, 'Click'), 
    acted_in(A, 'The Aviator').

% Was there a movie released in 2010 that did not star Jennifer Aniston?
q4(M) :- 
    released(M, 2010), 
    \+ acted_in('Jennifer Aniston', M).

% Who directed movies released in 2009? (don't worry about ; part)
q5(D) :- 
    released(Movie, 2009), 
    directed(D, Movie).

% Has anyone directed more than one movie?
q6(D) :- 
    directed(D, M1), 
    directed(D, M2), 
    M1 \= M2.

% Does any movie have more than one director?
q7(M) :- 
    directed(D1, M), 
    directed(D2, M), 
    D1 \= D2.

% Has anyone acted in more than one movie released in 2008?
q8(A) :- 
    acted_in(A, M1), 
    released(M1, 2008), 
    acted_in(A, M2), 
    released(M2, 2008), 
    M1 \= M2.

% Has anyone acted in more than two movies in the same year?
q9(A) :- 
    acted_in(A, M1), 
    released(M1, Y), 
    acted_in(A, M2), 
    released(M2, Y), 
    acted_in(A, M3), 
    released(M3, Y), 
    M1 \= M2, 
    M1 \= M3, 
    M2 \= M3.

% Who has worked with the same director in different years?
q10(A) :- 
    acted_in(A, M1), 
    directed(D, M1), 
    released(M1, Y1), 
    acted_in(A, M2), 
    directed(D, M2), 
    released(M2, Y2), 
    Y1 \= Y2.