eliza :-
    write_ln('how do you do. please tell me your problem'),
    write('? '),
    read_word_list(Input),
    eliza(Input).

eliza([bye]) :-
    % cut (exclamation mark) so that the program will terminate
    write_ln('bye. hope I could help you'), !.

% matching algorithm
eliza(Input) :-
    % getting a template from the defined templates.
    template(InputPattern, ResponsePattern),
    % getting a personal template to exchange pronounse like yourself or your.
    personal(PersonalInput,PersonalOutput),
    % matching personal input with the actual input.
    match(PersonalInput,Input),
    % matching output of the personal output so that we have a personaled input with exchanged your/my, etc.
    match(PersonalOutput,PersonalizedInput),
    % trying to match the template with the input.
    match(InputPattern, PersonalizedInput),
    % after matching input with a template, matching the response
    % with the defined response in template
    match(ResponsePattern, Response),
    !,
    % printing response.
    print_response(Response),
    % new input awaiting.
    read_word_list(NewInput),
    % call of eliza again.
    eliza(NewInput).

% user types in something and a list of tokenized atoms is returned
read_word_list(Ws) :-
    % a line the user typed in is converted into character codes
    % Cs = [104, 101, 108, 108, 111, 32, 116, 104, 101|...]
    read_line_to_codes(user_input, Cs),
    % convert character codes to an atom
    % A = 'hello there!'
    atom_codes(A, Cs),
    %  Break the text into words, numbers and punctuation characters
    % Ws = [hello, there, ',', how, are, you, ?].
    tokenize_atom(A, Ws).

% pretty-print a list of atoms since write_ln will output [it,like,this]
print_response([]) :-
    nl.
print_response([Head|Tail]) :-
    write(Head),
    write(' '),
    print_response(Tail).

% these are transformation rules to change the personal pronouns from me to you and the other way around.
personal([s(X),w(yourself)],[s(X),w(myself)]).
personal([s(X),w(yourself),s(Y)],[s(X),w(myself),s(Y)]).
personal([s(X),w(myself)],[s(X),w(yourself)]).
personal([s(X),w(myself),s(Y)],[s(X),w(yourself),s(Y)]).
personal([s(X),w(me)],[s(X),w(you)]).
personal([s(X),w(me),s(Y)],[s(X),w(you),s(Y)]).
personal([s(X),w(your),s(Y)],[s(X),w(my),s(Y)]).
personal([s(X),w(my),s(Y)],[s(X),w(your),s(Y)]).
personal([s(X),s([you, are]),s(Y)],[s(X),s([i,am]),s(Y)]).
personal([s(X),s([i,am]),s(Y)],[s(X),s([you,are]),s(Y)]).
personal([s(X)],[s(X)]).

% templates which we try to match the input with
% w == structure with one word or one character
% s == structure with a list of words (sentence)
% template([], []).
template([w(sorry),s(_)], [s([please,do,not,apologize])]).
template([s([i,remember]),s(X)], [s([why,do,you,remember]),s(X),s([just,now,?])]).
template([w(i),s(X),w(you)], [s([why,do,you]),s(X),w(me),w('?')]).
template([s([i,am]),s(X)], [s([why,are,you]),s(X),w('?')]).
template([s([i,think]),s(X)],[s([why,do,you,think]),s(X),w('?')]).
template([s([you,are]),s(X)], [s([what,makes,you,think,that,i,am]),s(X),w('?')]).
template([s([are,you]),s(X),w('?')], [s([what,makes,you,think,that,i,am]),s(X),w('?')]).
template([s([am,i]),s(X)], [s([do,you,believe,you,are]),s(X),w('?')]).
template([s([because]),s(_)], [s([why,do,you,think,that,'?'])]).
template([s(_)], [s([please,go,on])]).

% matching empty list with empty list
match([],[]).
% splitting up two lists of words into head and tail
match([PatternItem|PatternItems],[InputWord|InputWords]) :-
    match(PatternItem, PatternItems, InputWord, InputWords).

% matching a word structure
match(w(Word), PatternItems, Word, InputWords) :-
    match(PatternItems, InputWords).
% matching a sentence structure
match(s([Word|Seg]), Items, Word, Words0) :-
    append(Seg, Words1, Words0),
    match(Items, Words1).