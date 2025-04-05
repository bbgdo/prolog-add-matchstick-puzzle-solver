add1(-, +).
add1(0, 8).
add1(6, 8).
add1(9, 8).
add1(5, 6).
add1(3, 9).
add1(1, 7).
add1(5, 9).

add2(3, 8).
add2(5, 8).
add2(2, 8).
add2(4, 9).

% add one match solver

transformation([], []):- !.
transformation([H|T], [L|Changes]):-
    findall(Res, add1(H, Res), L),
    transformation(T, Changes).

transform_inverse([], []):- !.
transform_inverse([H|T], [L|Changes]):-
    findall(Res, add1(Res, H), L),
    transform_inverse(T, Changes).

list_in_expression([0|[_|_]], 0, ['false']):- !.
list_in_expression([], 0, []):- !.
list_in_expression([H|T], 0, [H|Res]):-
    (H == '+' ; H == '-' ; H == '='),
    list_in_expression(T, _, Res), !.

list_in_expression([H|T], Count, Res):-
    list_in_expression(T, Count1, R),
    ( (Count1 =:= 0, list_in_expression_0(H, R, Res))
    ; (Count1 > 0, list_in_expression_1(H, R, Count1, Res)) ),
    Count is Count1 + 1, !.

list_in_expression_0(H, R, [H|R]):- !.
list_in_expression_1(H, [H1|T1], Count, [ResN|T1]):-
    power10(Count, Powered),
    ResN is H * Powered + H1, !.

power10(1, 10):- !.
power10(Power, Res):-
    Power1 is Power - 1,
    power10(Power1, Res1),
    Res is 10 * Res1.

h(L, R):-
    findall(Lists, (
        append(L1, [Y|L2], L),
        length(Y, F), F > 0,
        empty(L1, R1),
        empty(L2, R2),
        member(X, Y),
        append(R1, [[X]|R2], Lists)
    ), R), !.

empty([], []):- !.
empty([_|T], [[]|R]):- empty(T, R).

transform_expression([], [], []).
transform_expression([H|T], [[]|T1], [H|R]):-
    transform_expression(T, T1, R), !.
transform_expression([_|T], [[Ch]|T1], [Ch|R]):-
    transform_expression(T, T1, R).

arifm([N1, =, N1]):- !.
arifm([N1|['-'|[N2|T]]]):-
    R is N1 - N2,
    arifm([R|T]), !.
arifm([N1|['+'|[N2|T]]]):-
    R is N1 + N2,
    arifm([R|T]).

x(L, Ch, R):-
    h(Ch, F),
    member(X, F),
    transform_expression(L, X, Res),
    list_in_expression(Res, _, R).

solution(L, R):-
    transformation(L, Ch),
    x(L, Ch, R),
    append(_,[E], R),
    not(E == 'false'),
    arifm(R).

generator(R, G):-
    transform_inverse(R, Ch2),
    x(R, Ch2, G),
    append(_,[E], G),
    not(E == 'false').

game_add_1(L, Res, Gen):-
    findall(R, solution(L, R), Res),
    findall(G, (member(R, Res), generator(R, G)), Gen), !.

% add two matches solver

transformation_add2([], []):- !.
transformation_add2([H|T], [L|Changes]):-
    findall(Res, add2(H, Res), L),
    transformation_add2(T, Changes).

solution_add2(L, R):-
    transformation_add2(L, Ch),
    x(L, Ch, R),
    append(_,[E], R),
    not(E == 'false'),
    arifm(R).

transform_inverse_add2([], []):- !.
transform_inverse_add2([H|T], [L|Changes]):-
    findall(Res, add2(Res, H), L),
    transform_inverse_add2(T, Changes).

generator_add2(R, G):-
    transform_inverse_add2(R, Ch2),
    x(R, Ch2, G),
    append(_,[E], G),
    not(E == 'false').

h2(Ch, Out):-
    length(Ch, Len),
    Upper is Len - 1,
    between(0, Upper, I),
    between(0, Upper, J),
    I < J,
    nth0(I, Ch, ListI),
    ListI \= [],
    nth0(J, Ch, ListJ),
    ListJ \= [],
    member(X, ListI),
    member(W, ListJ),
    empty(Ch, Empty),
    replace_nth(Empty, I, [X], Temp),
    replace_nth(Temp, J, [W], Out).

replace_nth([_|T], 0, Elem, [Elem|T]).
replace_nth([H|T], N, Elem, [H|R]):-
    N > 0,
    N1 is N - 1,
    replace_nth(T, N1, Elem, R).

solution2(L, R):-
    transformation(L, Ch),
    h2(Ch, F),
    transform_expression(L, F, Res),
    list_in_expression(Res, _, R),
    append(_,[E], R),
    not(E == 'false'),
    arifm(R).

game_add_2(L, Res, Gen):-
    findall(R, (solution2(L, R) ; solution_add2(L, R)), Res),
    findall(G, (member(R, Res), (generator(R, G) ; generator_add2(R, G))), Gen), !.


/** <examples>
?- game_add_1([1, 5, +, 2, =, 2, 1], Res, Gen).
Gen = [[19, -, 2, =, 21]],
Res = [[19, +, 2, =, 21]].

?- game_add_2([1, 5, +, 2, =, 2, 3], Res, Gen).
Gen = [[15, -, 8, =, 23], [15, +, 6, =, 23], [15, +, 9, =, 23], [15, +, 3, =, 23], [15, +, 5, =, 23], [15, +, 2, =, 23]],
Res = [[15, +, 8, =, 23]]

?- game_add_2([1, 5, +, 5, =, 2, 2], Res, Gen).
Gen = [[16, -, 6, =, 22], [16, +, 5, =, 22]],
Res = [[16, +, 6, =, 22]]
*/
