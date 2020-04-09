% First idea of a program that basically repeats what you say

eliza :-
    write_ln('how do you do. please tell me your problem'),
    write('? '),
    read_word_list(Input),
    eliza(Input).

eliza([bye]) :-
    % Cut (exclamation mark) so that the program will terminate
    write_ln('bye. hope I could help you'), !.

eliza(Input) :-
    write_ln(Input),
    write('? '),
    read_word_list(NewInput),
    eliza(NewInput).

% User types in something and a list of tokenized atoms is returned
read_word_list(Ws) :-
    % A line the user typed in is converted into character codes
    % Cs = [104, 101, 108, 108, 111, 32, 116, 104, 101|...]
    read_line_to_codes(user_input, Cs),
    % Convert character codes to an atom
    % A = 'hello there!'
    atom_codes(A, Cs),
    %  Break the text into words, numbers and punctuation characters
    % Ws = [hello, there, ',', how, are, you, ?].
    tokenize_atom(A, Ws).