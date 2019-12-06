
:- dynamic info/2.

start:-
  consult('/Users/oscar/Downloads/b_pinzones.txt'),
  fail.

start:-
  assert(si(end)),
  assert(no(end)),nl,nl,
  write('Bienvenido!'),nl,nl,
  write('Desea introducir un pinzon? (s/n): '),
  read(A),
  A = s,
  not(introducir), !,preguntar.

start:-
  preguntar.

introducir:-
  write('Que pinzon es? (fin - para terminar): '),
  read(Object),
  not(Object = 'fin'),
  atributos(Object, []),
  write('Otro pinzon(s/n)?: '),!,
  read(A), A = s,
  introducir.

atributos(Obj, Lista):-
  write(Obj),
  write('; Es/tiene/hace/come/longitud (fin - para terminar)?: '),
  read(Attribute),
  not(Attribute = 'fin'),
  add(Attribute, Lista, Lista2),
  atributos(Obj, Lista2).

  atributos(Obj, Lista):-
    assert(info(Obj, Lista)),
    open('/Users/oscar/Downloads/b_pinzones.txt', append, Stream),nl,
    write(Stream, 'user:info('),
    write(Stream, Obj),
    write(Stream, ','),
    write(Stream, Lista),
    write(Stream, ').'),
    nl(Stream),
    close(Stream).

/* pide informacion al usuario para encontrar un objeto(meta) */


preguntar:-
  info(O,A),
  anterioressi(A),
  anterioresno(A),
  intentar(O,A),
  purgar.

preguntar:-
  purgar,
  write('No se encontro el pinzon.').

/*Selecciona los objetos que tienen atributos apropiados ya determinados anteriormente */

anterioressi(A):-
  si(T), !,
  xanterioressi(T,A,[]), !.

xanterioressi(end,_,_):- !.

xanterioressi(T,A,L):-
  member(T,A), !,
  add(T,L,L2),
  si(X), not(member(X,L2)),!,
  xanterioressi(X,A,L2).

/* seleccionar todos los objetos que tienen atributos ya determinados como no pertenecientes al objeto */

anterioresno(A):-
  no(T),!,
  xanterioresno(T,A,[]), !.

xanterioresno(end,_,_):- !.

xanterioresno(T,A,L):-
  not(member(T,A)), !,
  add(T,L,L2),
  no(X),not(member(X,L2)), !,
  xanterioresno(X,A,L2).

  /* intentar una hipotesis(meta) */

intentar(O,[]):-
  write('El pinzon es: '),
  write(O), nl.

intentar(O,[X|T]):-
  si(X), !, intentar(O,T).

intentar(O,[X|T]):-
  write('Tiene el atributo '),
  write(X), write('? (s/n): '),
  read(R),
  procesar(O,X,R), !,
  intentar(O,T).

  /* procesar varias respuestas */

procesar(_,X,s):-
  asserta(si(X)), !.

procesar(_,X,n):-
  asserta(no(X)),!,fail.


procesar(O, X, why):-
  nl,write('Creo que puede ser: '), write(''),
  write(O),nl,nl, write('Porque tiene: '),nl,
  si(Z), xwrite(Z), nl,

  Z = end, !,
  write('Y no tiene: '),nl,
  no(Y), xwrite(Y), nl,
  Y = end, !,
  write('Tiene el atributo '),
  write(X), write('? (s/n): '),
  read(R),
  procesar(O,X,R), !.

xwrite(end).

xwrite(X):-
  write(X).

purgar:-
  retract(si(X)),
  X = end, fail.

purgar:-
  retract(no(X)),
  X = end.



member(X,[X|L]):- !.
member(X,[Y|L]):- member(X,L).

add(X,L,L):- member(X,L), !.
add(X, L,[X|L]).









