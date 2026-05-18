% =============================================================
% Charity Stall Volunteer Scheduling Puzzle
% =============================================================
% 20 shifts, 10 volunteers. Each volunteer works exactly 2 shifts.
% Every shift must be covered by exactly one volunteer,
% and volunteers can only cover shifts in their availability.
% This puzzle has exactly ONE valid assignment.
%
% --- Shifts: shift(Id, Stall, Hour) ---
shift(1, 'Cake Stall', '10:00').
shift(2, 'Cake Stall', '11:00').
shift(3, 'Cake Stall', '12:00').
shift(4, 'Cake Stall', '13:00').
shift(5, 'Tombola', '10:00').
shift(6, 'Tombola', '11:00').
shift(7, 'Tombola', '12:00').
shift(8, 'Tombola', '13:00').
shift(9, 'BBQ', '10:00').
shift(10, 'BBQ', '11:00').
shift(11, 'BBQ', '12:00').
shift(12, 'BBQ', '13:00').
shift(13, 'Book Stall', '10:00').
shift(14, 'Book Stall', '11:00').
shift(15, 'Book Stall', '12:00').
shift(16, 'Book Stall', '13:00').
shift(17, 'Crafts', '10:00').
shift(18, 'Crafts', '11:00').
shift(19, 'Crafts', '12:00').
shift(20, 'Crafts', '13:00').

% --- Availabilities: available(Name, [ShiftIds]) ---
available(alice, [1,11,13]).
available(bob, [5,12,16,17,20]).
available(carol, [1,2]).
available(david, [3,12,16,18]).
available(eve, [7,14]).
available(frank, [3,6]).
available(grace, [9,12]).
available(henry, [8,10]).
available(ivy, [15,20]).
available(jack, [4,16,19]).

% --- Reference solution (kept here as a comment) ---
%   alice -> shifts [11,13]
%   bob -> shifts [5,17]
%   carol -> shifts [1,2]
%   david -> shifts [16,18]
%   eve -> shifts [7,14]
%   frank -> shifts [3,6]
%   grace -> shifts [9,12]
%   henry -> shifts [8,10]
%   ivy -> shifts [15,20]
%   jack -> shifts [4,19]
