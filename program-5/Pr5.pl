%consider pattern matching and head-tail notation for these

exactly3(L):-fail.

at_least_3(L):-fail.

at_most_3(L):-fail.


intersect(L1,L2):-fail.

all_intersect(ListofLists,L):-fail.


%source removal, see pdf. You'll probably want to define helper predicates
% assume G is set and you need to return list of nodes
% as [a,b,d...], not [ [a|[v,d]], [b| [d] ], [d| [c,x]],... ]
source_removal(G,Toposort):-fail.
