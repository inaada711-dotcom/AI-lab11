:- dynamic letter/1.

letter(a).
letter(b).
letter(c).

start :-
    nl,
    write('Hi. This is the "Name Game".'), nl,
    write('You will be given a set of English letters in which you will add, delete or move to create your name.'), nl,
    menu.

menu :-
    nl,
    write('Choose from the following:'), nl,
    write('1- Display the current set of letters'), nl,
    write('2- Add a letter'), nl,
    write('3- Add a letter at the top'), nl,
    write('4- Add a letter at the bottom'), nl,
    write('5- Delete a letter'), nl,
    write('6- Delete all letters'), nl,
    write('7- Exit'), nl,
    write('Enter your choice....'), nl,
    read(Choice),
    do(Choice).


do(1) :- !,
    findall(L, letter(L), Letters),
    ( Letters == [] -> write('The set is empty.') ; write(Letters) ),
    nl,
    menu.


do(2) :- !, add_letter(plain),  menu.
do(3) :- !, add_letter(top),    menu.
do(4) :- !, add_letter(bottom), menu.


do(5) :- !,
    write('Enter the letter to delete: '),
    read(L),
    ( retract(letter(L)) -> write('Letter deleted.')
    ; write('That letter is not in the set.') ),
    nl,
    menu.


do(6) :- !,
    retractall(letter(_)),
    write('All letters deleted.'), nl,
    menu.


do(7) :- !,
    write('Goodbye!'), nl.


do(_) :-
    write('Invalid choice, try again.'), nl,
    menu.

add_letter(Mode) :-
    write('Enter the letter : '),
    read(L),
    (   atom(L)
    ->  (   Mode == top    -> asserta(letter(L))
        ;   Mode == bottom -> assertz(letter(L))
        ;   assert(letter(L))
        ),
        write('Letter added.'), nl
    ;   write('Please enter a lowercase letter.'), nl
    ).