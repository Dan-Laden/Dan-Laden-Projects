% Daniel Laden
% CSCI 305 Prolog labled

/* Royal Family of England 1900-2000 */
?- consult(royal).

%F is a father to C
father(F, C) :-
  parent(F, C), male(F), not(F=C).

%M is a mother to C
mother(M, C) :-
  parent(M, C), female(M), not(M=C).

%X is married to Y and thus a spouse
spouse(X, Y) :- married(X, Y).
spouse(X, Y) :- married(Y, X).

%C is a child to P
child(C, P) :- parent(P, C).

%S is a son to P
son(S, P) :- parent(P, S), male(S).

%D is a daughter to P
daughter(D, P) :- parent(P, D), female(D).

%X is a sibling of Y
sibling(X, Y) :-
  father(P, X), father(P, Y), not(X=Y).

%B is a bro to S (also a brother)
brother(B, S) :-
  sibling(S, B), male(B).

%S is a sister to B
sister(S, B) :-
  sibling(S, B), female(S).

%U is an uncle of N
%This is by blood
uncle(U, N) :-
  parent(P, N), brother(U, P).

%This is by marriage
uncle(U, N) :-
  spouse(N, SP), parent(P, SP), brother(U, P).

%A is an aunt of N
%this is by blood
aunt(A, N) :-
  parent(P, N), sister(A, P).

%this is by marriage
aunt(A, N) :-
  spouse(N, SP), parent(P, SP), sister(A, P).

%GP is the grandparent of GC
grandparent(GP, GC) :-
  parent(GP, F), parent(F, GC).

%GF is the grandfather of GC
grandfather(GF, GC) :-
  parent(GF, P), parent(P, GC), male(GF).

%GM is the grandmother of GC
grandmother(GM, GC) :-
  parent(GM, P), parent(P, GC), female(GM).

%GC is the grandchild of GP
grandchild(GC, GP) :-
  parent(GP, F), parent(F, GC).

%X is an ancestor of Y
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :-
  parent(Z, Y), ancestor(X, Z).

%X is a decendant of Y opposite of Ancestor
decendant(X, Y) :- parent(Y, X).
decendant(X, Y) :-
  parent(Z, X), decendant(Z, Y).

%X is older than Y NOTE: I tried to have it subtract if they were dead or not but I don't understand why
%Prolog gets stuck on the same declaration over and over.
older(X, Y) :-
  born(X, XB),
  ((died(X, XD), NewX is (XD - XB)); NewX is (2018 - XB)),
  born(Y, YB),
  ((died(Y, YD), NewY is (YD - YB)); NewY is (2018 - YB)),
  NewX > NewY.

%X is younger than Y. opposite of older
younger(X, Y) :-
  older(Y, X).

%X was in throne when Y was born
regentWhenBorn(X, Y) :-
  reigned(X, SY, EY),
  born(Y, YB),
  YB >= SY,
  YB =< EY.

%C is a cousing to Y
cousin(C, Y) :-
  parent(P, Y), sibling(UA, P), parent(UA, C).
