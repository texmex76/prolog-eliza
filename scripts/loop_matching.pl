eliza :-
    write_ln('how do you do. please tell me your problem'),
    write('? '),
    read_word_list(Input),
    eliza(Input).

eliza([bye]) :-
    % Cut (exclamation mark) so that the program will terminate
    write_ln('bye. hope I could help you'), !.

% matching algorithm
eliza(Input) :-
    % getting a template from the defined templates.
    template(InternalStimuli, InternalResponse),
    % trying to match the template with the input.
    match(InternalStimuli, Input),
    % after matching input with an template, matching the response with the defined response in template.
    match(InternalResponse, Response),
    !,
    % printing response.
    print_response(Response),
    % new input awaiting.
    read_word_list(NewInput),
    % call of eliza again.
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

% Pretty-print a list of atoms since write_ln will output [it,like,this]
print_response([]) :-
    nl.
print_response([Head|Tail]) :-
    write(Head),
    write(' '),
    print_response(Tail).

% templates which we try to match the input with.
% w == structure with one word or one character.
% s == structure with a list of words (sentence)
template([s([i,am]),s(X)], [s([why,are,you]),s(X),w('?')]).
template([s([I,am]),s(X)], [s([why,are,you]),s(X),w('?')]).
template([w(i),s(X),w(you)], [s([why,do,you]),s(X),w(me),w('?')]).

% matching nothing with nothing.
match([],[]).
% matching two lists of words.
match([Item|Items],[Word|Words]) :-
    match(Item, Items, Word, Words).

% matching a word structure.
match(w(Word), Items, Word, Words) :-
    match(Items, Words).
% matching a sentence structure.
match(s([Word|Seg]), Items, Word, Words0) :-
    append(Seg, Words1, Words0),
    match(Items, Words1).