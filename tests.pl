% Dejar esto al principio del archivo. Carga el archivo del dominio.
:- consult('solucion.pl'). 
%--------figuritasObtenidas
:- begin_tests(figuritasObtenidas).

test(figuritasObtenidasBobby,[nondet]):- 
    findall(F,figuritasObtenidas(bobby,F), Figuritas),
    Figuritas == [3,5,7,1,4,6,2].

test(figuritasObtenidasLala,[nondet]):- 
    findall(F,figuritasObtenidas(lala,F), Figuritas),
    Figuritas == [1,3,7,5,9,1,3].

test(figuritasObtenidas,[nondet]):- 
    findall(F,figuritasObtenidas(juanchi,F), Figuritas),
    Figuritas == [].    

:- end_tests(figuritasObtenidas).

%--------figuritasRepetidas
:- begin_tests(figuritasRepetidas).

test(figuritasRepetidasFlor,[nondet]):-
    figuritaRepetida(flor,5).

test(figuritasRepetidasAndy,[nondet]):-
    findall(F,figuritaRepetida(andy,F),Repetidas),
    Repetidas \= [].    
:- end_tests(figuritasRepetidas).

%--------figuritaRara
:- begin_tests(figuritaRara).

test(figuritaRara,[nondet]):-
    figuritaRara(8).

test(figuritaRara,[nondet]):-
    figuritaRara(2).

test(figuritaRara,fail):-
    figuritaRara(1).

:- end_tests(figuritaRara).

%--------figuritaBrillante
:- begin_tests(figuritaBrillante).

test(figuritaBrillante,[nondet]):-
    figuritaBrillante(2).

test(figuritaBrillante,[nondet]):-
    figuritaBrillante(3).

:- end_tests(figuritaBrillante).

% Dejar esto al final del archivo para que se ejecuten automáticamente al cargarlo mediante SWI Prolog.
:- run_tests.
