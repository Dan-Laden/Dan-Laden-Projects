location(0, 0).
location(0, 1).
location(1, 0).
location(1, 1).

is_location(X, Y) :- location(X, Y).

is_lethal(X, Y) :- at(pit, X, Y) ; at(wumpus, X, Y).

go_to(X, Y) :- 
    is_location(X, Y),
    \+ is_lethal(X, Y),
    retract(at(player, _, _)),
    assertz(at(player, X, Y)).

glitter :-
    at(player, X, Y),
    at(gold, X, Y).

x_of(O, R) :-
    at(O, X, _),
    R is X.

y_of(O, R) :-
    at(O, _, Y),
    R is Y.

%% Having a hard time figuring out how to save out the results of a query
%% (at(player, X, Y)) and reuse for other queries (at(wumpus, X+1, Y), 
%% etc...).
stench(X, Y) :-
    X is x_of(player, _X),
    Y is y_of(player, _Y),
    at(wumpus, X+1, Y);
    at(wumpus, X-1, Y);
    at(wumpus, X, Y+1);
    at(wumpus, X, Y-1).

%% breeze :-
%%     at(player, X, Y),
%%     at(pit, X+1, Y);
%%     at(pit, X-1, Y);
%%     at(pit, X, Y+1);
%%     at(pit, X, Y-1).

%% glitter :-
%%     assertz(at(gold, X, Y)).

%% smell :-

%% shoot(D) :-
%%    shoot(D, )

main :-
    assertz(at(player, 0, 0)),
    assertz(at(gold, 0, 0)),
    assertz(at(wumpus, 1, 1)).