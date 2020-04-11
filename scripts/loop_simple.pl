% First idea of a program that basically repeats what you say
% User can only type in atoms or lists

eliza :-
    write_ln('how do you do. please tell me your problem'),
    write('? '),
    read(user_input, Input),
    eliza(Input).

eliza([bye]) :-
    % Cut (exclamation mark) so that the program will terminate
    write_ln('bye. hope I could help you'), !.

eliza(Input) :-
    write_ln(Input),
    write('? '),
    read(user_input, NewInput),
    eliza(NewInput).