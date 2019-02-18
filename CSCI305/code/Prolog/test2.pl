

max(X, Y, Z) :-
  X =:= Y,
  Z is X,
  !.

max(X, Y, Z) :-
  X < Y,
  Z is Y,
  !.

max(X, Y, Z) :-
  X > Y,
  Z is X,
  !.

subsetsum([L|T], Sum, SubL) :-
  L =:= Sum

sum(N, [L|T], Sum) :-
