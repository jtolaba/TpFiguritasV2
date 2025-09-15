% Dejar esto al principio del archivo. Carga el archivo del dominio.
:- consult('solucion.pl'). 

%-----------------------------------------------------------------------------
%   De canjes y paquetes
%-----------------------------------------------------------------------------

%--------figuritasObtenidas
:- begin_tests(figuritasObtenidas).

test(figuritas_obetnidas_por_bobby,[nondet]):- 
    findall(F,figuritasObtenidas(bobby,F), Figuritas),
    Figuritas == [3,5,7,1,4,6].

test(figuritas_obtenidas_por_lala,[nondet]):- 
    findall(F,figuritasObtenidas(lala,F), Figuritas),
    Figuritas == [1,3,7,5,9].

test(juanchi_no_tiene_figuritas,[nondet]):- 
    findall(F,figuritasObtenidas(juanchi,F), Figuritas),
    Figuritas == [].    

:- end_tests(figuritasObtenidas).

%--------figuritasRepetidas
:- begin_tests(figuritasRepetidas).

test(figuritas_repetidas_de_flor,[nondet]):-
    figuritaRepetida(flor,5).

test(andy_no_tiene_figuritas_repetidas,[nondet]):-
    findall(F,figuritaRepetida(andy,F),Repetidas),
    Repetidas \= [].    
:- end_tests(figuritasRepetidas).

%--------figuritaRara
:- begin_tests(figuritaRara).

test(es_una_figurita_rara,[nondet]):-
    figuritaRara(8).

test(es_una_figurita_rara,[nondet]):-
    figuritaRara(2).

test(no_es_una_figurita_rara,fail):-
    figuritaRara(1).

:- end_tests(figuritaRara).

%-----------------------------------------------------------------------------
%   Imágenes y personajes
%-----------------------------------------------------------------------------

%--------figuritaBrillante
:- begin_tests(figuritaBrillante).

test(es_una_figurita_brillante,[nondet]):-
    figuritaBrillante(2).

test(es_una_figurita_brillante,[nondet]):-
    figuritaBrillante(3).

:- end_tests(figuritaBrillante).

%--------figuritaBasica
:- begin_tests(figuritaBasica).

test(hay_al_menos_una_figurita_basica,[nondet]):-
    figuritaBasica(_).

:- end_tests(figuritaBasica).

%--------figuritaDeRompecabezas
:- begin_tests(figuritaDeRompecabezas).

test(es_parte_del_rompécabeza_restaurante,[nondet]):-
    figuritaDeRompecabezas(restaurante,5),
    figuritaDeRompecabezas(restaurante,6),
    figuritaDeRompecabezas(restaurante,7).

:- end_tests(figuritaDeRompecabezas).

%--------figuritaValiosa
:- begin_tests(figuritaValiosa).

test(no_es_figurita_valiosa,fail):-
    figuritaValiosa(5).

test(es_figurita_valiosa,nondet):-
    figuritaValiosa(1).

test(es_figurita_valiosa,nondet):-
    figuritaValiosa(4).

:- end_tests(figuritaValiosa).

%--------valorDeInteresante
:- begin_tests(valorDeInteresante).

test(valor_de_interes_del_primer_paquete_abierto_por_lala,nondet):-
    valorPaquete(lala,1,43).

test(valor_de_interes_figuritas_obtenidas_por_pablito_en_canje_con_toto,nondet):-
    valorCanje(pablito, toto, 45).
:- end_tests(valorDeInteresante).

%-----------------------------------------------------------------------------
%   Cambio, cambio…
%-----------------------------------------------------------------------------

%--------hizoNegocio
:- begin_tests(hizoNegocio).

test(pablito_hizo_negocio_con_lala,true,nondet):-
    hizoNegocio(pablito,lala).

test(toto_hizo_negocio_con_pablito,fail):-
% Ambos intercambiaron figuritasValiosas
    hizoNegocio(toto,pablito).

test(hizo_negocio_inexistente,fail):-
    hizoNegocio(jorge,pablito).

:- end_tests(hizoNegocio).


%--------esUnaAmaneza
:- begin_tests(esUnaAmenaza).

test(quien_es_una_amenaza,nondet):-
    esUnaAmenaza(emi),
    esUnaAmenaza(pablito). 

test(lala_no_es_una_amenza,fail):-
    esUnaAmenaza(lala).
    
:- end_tests(esUnaAmenaza).

%--------necesitaFigurita
:- begin_tests(necesitaFigurita).

test(figuritas_que_necesita_andy):-
    necesitaFigurita(andy,3).

test(figuritas_que_necesita_lala):-
    necesitaFigurita(lala,6)
    
:- end_tests(necesitaFigurita).

%--------posiblesCanjes
:- begin_tests(posiblesCanjes).

test(andy_entregaria_en_canje_solo_figurita_repetida,nondet):-
    figuritaRepetida(andy, Figurita),
    posiblesCanjes(andy,_,FiguritasQueEntregaria,_),
    member(Figurita,FiguritasQueEntregaria).

test(andy_entregaria_en_canje_figurita_no_repetida, fail, nondet) :-
    posiblesCanjes(andy, _, FiguritasQueEntregaria, _),
    member(F, FiguritasQueEntregaria),
    \+ figuritaRepetida(andy, F).


test(andy_solo_busca_figuritas_que_necesita,nondet):-
    necesitaFigurita(andy,Figurita),
    posiblesCanjes(andy,Figurita,_,_).
    
:- end_tests(posiblesCanjes).

% Dejar esto al final del archivo para que se ejecuten automáticamente al cargarlo mediante SWI Prolog.
:- run_tests.
