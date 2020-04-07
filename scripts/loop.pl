% Trying to figure out how to create an infinite
% loop in Prolog

quit_eliza :-
    write('Bye. Hope I could help you.').

eliza(_) :-
    read(X),
    write(X), nl,
    quit(X) -> quit_eliza; eliza(_).

eliza :-
    write('Hello, I am Eliza. How can I help you?'), nl,
    eliza(_).

quit(bye).