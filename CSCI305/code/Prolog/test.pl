isMember(X, [Y|T]) :-
  X=Y;
  isMember(X,T).

isUnion([X|XT], [Y|YT], Z) :-
  not(X=Y);
  isMember(X, Z);
  isMember(Y, Z);
  isUnion(XT, YT, Z).

isIntersection([X|XT], [Y|YT], Z) :-
  isIntersection(X, YT, Z);
  isIntersection(Y, XT, Z).

isIntersection(X, [Y|YT], Z) :-
  X=Y;
  isMember(X, Z);
  isIntersection(X, YT, Z).

female(jill).
male(bob).
female(child).
parent(bob, child).
parent(bob, chris).
parent(jill, child).
parent(jill, chris).

father(F, C) :-
  parent(F, C), male(F), not(F=C).

mother(M, C) :-
  parent(M, C), female(M), not(M=C).

sister(S, B) :-
  not(S=B), parent(P, S), parent(P, B) female(S).

brother(B, S) :-
  not(B=S), parent(P, B), parent(P, S), male(B).

grandson(GC, P) :-
  parent(GP, P), parent(GP, GC), male(GC), not(GC=P).
