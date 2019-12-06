
% Native - a simple shell for use with Prolog
% knowledge bases.  It includes expanations.
:-style_check(-singleton).

go :-
	greeting,
	repeat,
	write('>>>>>> '),
	read(X),
	do(X),
	X == quit.

greeting :-
	write('Esta es una shell nativa en prolog.'), nl,
	native_help.

do(help) :-
	native_help, !.
do(justify):-
	justifica,!.
do(load) :-
	load_kb, !.
do(consult) :-
	solve, !.
do(quit).
do(X) :-
	write(X),
	write(' es un comando no valido.'), nl,
	fail.

native_help :-
	write('ayuda, cargar (load), consultar (consult), justificar(justify) o quitar (quit)'),nl,
	write('en el prompt.'), nl.

load_kb :-
	write('Introduce el nombre del archivo entre'),nl,
	write('comillas simples (ej. ''birds.txt''.): '),
	read(F),
	consult(F),
	write('cargar (load), consultar (consult), justificar(justify) o quitar (quit)'),nl.

solve :-
	retractall(known(_, _, _)),
	top_goal(X),
	write('La respuesta es: '),write(X),nl,nl,
	write('cargar (load), consultar (consult), justificar(justify) o quitar (quit)'),nl.

solve :-
	write('Respuesta no encontrada.'),nl,nl,
	write('cargar (load), consultar (consult), justificar(justify) o quitar (quit)'),nl.

justifica:-
	writeln("-------Justificacion de la respuesta"),
	writeln("------- Porque Si tiene"),
	print(si),
	writeln("------- Porque No tiene"),
	print(no).
	
print(Z):-
 forall(known(Z,A,V), writeln(A:V)).

