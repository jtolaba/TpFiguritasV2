/* Solución TP Lógico 2025 */
albumCompleto(Figuritas):-
	findall(Numero, figurita(Numero, _), Todas),
	sort(Todas, ListaOrdenada),
	sort(Figuritas, ListaOrdenada).

coleccionista(andy).
coleccionista(flor).
coleccionista(bobby).
coleccionista(lala).
coleccionista(toto).
coleccionista(emi).
coleccionista(pablito).

obtuvoEn(paquete, andy, 1, 2).
obtuvoEn(paquete, andy, 1, 4).
obtuvoEn(paquete, andy, 2, 6).
obtuvoEn(paquete, andy, 2, 7).
obtuvoEn(paquete, andy, 3, 1).
obtuvoEn(paquete, andy, 3, 5).
obtuvoEn(paquete, andy, 3, 8).
obtuvoEn(paquete, flor, 1, 5).
obtuvoEn(paquete, flor, 2, 5).
% obtuvoEn(paquete,flor,2,8). %agregado para prueba.
% obtuvoEn(paquete,flor,2,8). %agregado para prueba.
obtuvoEn(paquete, bobby, 1, 3).
obtuvoEn(paquete, bobby, 1, 5).
obtuvoEn(paquete, bobby, 2, 7).
% obtuvoEn(paquete,bobby,2,8). %agregado para prueba.
obtuvoEn(paquete, lala, 1, 1).
obtuvoEn(paquete, lala, 1, 3).
obtuvoEn(paquete, lala, 1, 7).
obtuvoEn(paquete, toto, 1, 1).
% obtuvoEn(paquete,toto,2,8). %agregado para prueba.
obtuvoEn(paquete, emi, 1, 9).
obtuvoEn(paquete, emi, 1, 10).
obtuvoEn(paquete, emi, 2, 9).
obtuvoEn(paquete, emi, 2, 10).
% obtuvoEn(paquete,emi,2,8). %agregado para prueba.
obtuvoEn(canje, pablito, 2, toto).
obtuvoEn(canje, toto, 6, pablito).
obtuvoEn(canje, pablito, 1, lala).
obtuvoEn(canje, lala, 5, pablito).
obtuvoEn(canje, emi, 3, lala).
obtuvoEn(canje, lala, 9, emi).
obtuvoEn(canje, emi, 2, toto).
obtuvoEn(canje, toto, 10, emi).
obtuvoEn(canje, flor, 2, bobby).
obtuvoEn(canje, bobby, 1, flor).
obtuvoEn(canje, bobby, 4, flor).
obtuvoEn(canje, bobby, 6, flor).
obtuvoEn(canje, andy, 1, flor).
obtuvoEn(canje, flor, 4, andy).
obtuvoEn(canje, flor, 7, andy).


%-----------------------------------------------------------------------------
%   Punto 1 : figuritasObtenidas/2
%-----------------------------------------------------------------------------

figuritasObtenidas(Persona, Figurita):-
	obtuvoEn(paquete, Persona, _, Figurita).

figuritasObtenidas(Persona, Figurita):-
	obtuvoEn(canje, Persona, Figurita, _).

% figuritasObtenidas(Persona, Figurita):-
% 	obtuvoEn(canje, _, Figurita, Persona).


%-----------------------------------------------------------------------------
%   Punto 2 : figuritaRepetida/2
%-----------------------------------------------------------------------------

figuritaRepetida(Persona, Figurita):-
	coleccionista(Persona),
	findall(F, figuritasObtenidas(Persona, F), Figuritas),
    include(duplicado(Figuritas), Figuritas, Repetidas), sort(Repetidas, Unicas),
	member(Figurita, Unicas).
  
duplicado(Figuritas, Figurita):-
	select(Figurita, Figuritas, RestoFiguritas),
	member(Figurita, RestoFiguritas).

%-----------------------------------------------------------------------------
%   Punto 3 : figuritaRara/1
%-----------------------------------------------------------------------------

figuritaRara(Figurita):-
	findall(F,(obtuvoEn(paquete, _, Numero, F),	Numero =< 2),Figuritas),
	not(member(Figurita, Figuritas)).

figuritaRara(Figurita):-
    obtuvoEn(canje,PersonaA,Figurita,PersonaB),
    findall(FiguritaRecibida,obtuvoEn(canje,PersonaB,FiguritaRecibida,PersonaA),FiguritasRecibidas),
    length(FiguritasRecibidas, CantidadRecibida),
    CantidadRecibida >=3.

figuritaRara(Figurita):-
	findall(Persona, figuritasObtenidas(Persona, Figurita),	Personas),
	length(Personas, CantidadPersonasQueLatienen),
	findall(Coleccionista, coleccionista(Coleccionista), Coleccionistas),
	length(Coleccionistas, CantidadDeColeccionistas),
	CantidadPersonasQueLatienen < (CantidadDeColeccionistas/2),
	not(figuritaRepetida(_, Figurita)).

%-----------------------------------------------------------------------------
%   Punto 4 : personajes(nombre,popularidad)
%-----------------------------------------------------------------------------
personajes(kitty, 5).
personajes(cinnamoroll, 4).
personajes(badtzMaru, 2).
personajes(keroppi, 3).
personajes(pompompurin, 4).
personajes(gudetama, 1).
personajes(myMelody, 3).
personajes(littleTwinStars, 2).
personajes(kuromi, 5).

figurita(1, basica([kitty, keroppi])).
figurita(2, brillante(kitty)).
figurita(3, brillante(myMelody)).
figurita(4, basica(escenario)).
figurita(5, rompecabezas(restaurante)).
figurita(6, rompecabezas(restaurante)).
figurita(7, rompecabezas(restaurante)).
figurita(8, basica([kitty, cinnamoroll, badtzMaru, keroppi, pompompurin, gudetama, myMelody, littleTwinStars, kuromi])).
figurita(9, basica(escenario)).
figurita(10, basica(escenario)).

figurita(Figurita):-
    figurita(Figurita,_).

figuritaBrillante(Figurita):-
    figurita(Figurita, brillante(_)).

figuritaBasica(Figurita):-
	figurita(Figurita, basica(_)).

figuritaDeRompecabezas(Tipo, Figurita):-
	figurita(Figurita, rompecabezas(Tipo)).

%-----------------------------------------------------------------------------
%   Punto 5 : figuritaValiosa/1
%-----------------------------------------------------------------------------

figuritaValiosa(Figurita) :-
	figuritaRara(Figurita).

figuritaValiosa(Figurita) :-
	nivelDeAtractivo(Figurita, Atractivo),
	Atractivo > 7.

nivelDeAtractivo(Figurita, Atractivo):-
	figuritaBrillante(Figurita),
	figurita(Figurita, brillante(Personaje)),
    personajes(Personaje,Popularidad),
	Atractivo is Popularidad*5.

nivelDeAtractivo(Figurita, Atractivo):-
    figuritaBasica(Figurita),
    figurita(Figurita, basica(Personajes)),
    findall(Pop, (member(P, Personajes), personajes(P, Pop)), Popularidades),
    sumlist(Popularidades, Atractivo).

nivelDeAtractivo(Figurita, 2):-
	figurita(Figurita, rompecabezas(Tipo)),	cantidadDePiezasRompecabezas(Tipo, Cantidad),
	Cantidad =< 2.

nivelDeAtractivo(Figurita, 0):-
	figurita(Figurita,rompecabezas(Tipo)), cantidadDePiezasRompecabezas(Tipo, Cantidad),
	Cantidad > 2.

cantidadDePiezasRompecabezas(Tipo, Cantidad):-
	findall(Figurita, figuritaDeRompecabezas(Tipo, Figurita), Figuritas),
	length(Figuritas, Cantidad).
    
%-----------------------------------------------------------------------------
%   Punto 6 : valorPaquete/3 y valorCanje/3
%-----------------------------------------------------------------------------
valorPaquete(Persona,Paquete,Puntaje):-
	coleccionista(Persona),
	findall(Figurita,obtuvoEn(paquete,Persona,Paquete,Figurita), FiguritasObtenidasEnPaquete),
	valorDeInteresante(FiguritasObtenidasEnPaquete,Puntaje).

valorCanje(ColeccionistaA, ColeccionistaB, Puntaje):-
	coleccionista(ColeccionistaA),
	coleccionista(ColeccionistaB),
	ColeccionistaA \= ColeccionistaB,
	findall(Figurita,obtuvoEn(canje,ColeccionistaA,Figurita,ColeccionistaB), FiguritasObtenidasEnCanje),
	valorDeInteresante(FiguritasObtenidasEnCanje,Puntaje).


valorDeInteresante(Figuritas,Puntaje):-
	maplist(nivelDeAtractivo, Figuritas, NivelDeAtractivoCartas),
	sumlist(NivelDeAtractivoCartas, PuntajeParcial),
	obtuvoFiguritaRara(Figuritas,PuntajeParcial,Puntaje).

obtuvoFiguritaRara(Figuritas,PuntajeParcial,Puntaje):-
	include(figuritaRara, Figuritas, FiguritasRara),
	length(FiguritasRara, CantidadRaras),
	Puntaje is PuntajeParcial + (CantidadRaras * 20).

%-----------------------------------------------------------------------------
%   Punto 6 : valorPaquete/1
%-----------------------------------------------------------------------------
%shell(clear).