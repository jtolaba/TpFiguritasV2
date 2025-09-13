
% Dejar esto al principio del archivo. Carga el archivo del dominio.
:- consult('solucion.pl'). 
%--------figuritasObtenidas
:- begin_tests(figuritasObtenidas).

test(figuritasObtenidasBobby,[nondet]):- 
    findall(F,figuritasObtenidas(bobby,F), Figuritas),
    Figuritas == [3,5,7,1,4,6].
    
test(figuritasObtenidasLala,[nondet]):- 
    findall(F,figuritasObtenidas(lala,F), Figuritas),
    Figuritas == [1,3,7,5,9].    


:- end_tests(figuritasObtenidas).

%--------figuritasRepetidas
:- begin_tests(figuritasRepetidas).

test(figuritasRepetidasFlor,[nondet]):-
    figuritaRepetida(flor,5).

test(figuritasRepetidasAndy,[nondet]):-
    findall(F,figuritaRepetida(andy,F),Repetidas),
    Repetidas \= [].    
:- end_tests(figuritasRepetidas).

% Dejar esto al final del archivo para que se ejecuten automáticamente al cargarlo mediante SWI Prolog.
:- run_tests.
