/* Solución TP Lógico 2025 */
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
obtuvoEn(paquete, andy, 4, 9).
obtuvoEn(paquete, andy, 4, 10).
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
% obtuvoEn(paquete,toto,2,8). % agregado para prueba.
obtuvoEn(paquete, emi, 1, 9).
obtuvoEn(paquete, emi, 1, 10).
obtuvoEn(paquete, emi, 2, 9).
obtuvoEn(paquete, emi, 2, 10).
obtuvoEn(paquete, emi, 3, 5).
obtuvoEn(paquete, emi, 3, 6).

% obtuvoEn(paquete,emi,2,8). % agregado para prueba.
obtuvoEn(canje, pablito, [2], toto, [6]).
obtuvoEn(canje, pablito, [1], lala, [5]).
obtuvoEn(canje, emi, [3], lala, [9]).
obtuvoEn(canje, emi, [2], toto,[10]).
obtuvoEn(canje, flor, [2], bobby, [1,4,6]).
obtuvoEn(canje, andy, [1], flor, [4,7]).

%-----------------------------------------------------------------------------
%   Punto 1 : figuritasObtenidas/2
%-----------------------------------------------------------------------------

figuritasObtenidas(Persona, Figurita):-
	coleccionista(Persona),
	obtuvoEn(paquete, Persona, _, Figurita).

figuritasObtenidas(Persona, Figurita):-
	coleccionista(Persona),
	(findall(F,obtuvoEn(canje,Persona,F,_,_),Figuritas);
	findall(F,obtuvoEn(canje,_,_,Persona,F),Figuritas)),
	flatten(Figuritas, FiguritasRecibidas),
	member(Figurita, FiguritasRecibidas).

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

figuritaRara(Figurita) :-
    (obtuvoEn(canje, _,FiguritasRecibidas, _, FiguritasDadas);
	obtuvoEn(canje, _, FiguritasDadas, _, FiguritasRecibidas)),
    member(Figurita, FiguritasRecibidas),
    length(FiguritasDadas, CantidadRecibida),
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
	figurita(Figurita,_),
	figuritaRara(Figurita).

figuritaValiosa(Figurita) :-
	figurita(Figurita,_),
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
	(obtuvoEn(canje,ColeccionistaA,FiguritasObtenidasEnCanje,ColeccionistaB,_);
	obtuvoEn(canje,ColeccionistaB,_,ColeccionistaA,FiguritasObtenidasEnCanje)),
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
%   Punto 7: hizoNegocio
%-----------------------------------------------------------------------------
hizoNegocio(Ganador,Perdedor):-
	coleccionista(Ganador),
	coleccionista(Perdedor),
	Ganador \= Perdedor,
	(obtuvoEn(canje,Ganador,ObtenidasPorGanador,Perdedor,ObtenidasPorPerdedor);
	obtuvoEn(canje,Perdedor,ObtenidasPorPerdedor,Ganador,ObtenidasPorGanador)),
	include(figuritaValiosa, ObtenidasPorGanador, ValiosasObtenidasPorGanador), ValiosasObtenidasPorGanador \= [],
	forall(member(Figurita,ObtenidasPorPerdedor), \+ figuritaValiosa(Figurita)).
	
esUnaAmenaza(Coleccionista) :-
    coleccionista(Coleccionista),
    canjesRealizados(Coleccionista, OtrosColeccionistas),
    member(ColeccionistaB, OtrosColeccionistas),
    hizoNegocio(Coleccionista, ColeccionistaB),
    forall(member(OtroColeccionista, OtrosColeccionistas),obtuvoMayorPuntajeDeCartasRecibidas(Coleccionista, OtroColeccionista)).

obtuvoMayorPuntajeDeCartasRecibidas(ColeccionistaA,ColeccionistaB):-
	valorCanje(ColeccionistaA, ColeccionistaB, PuntajeA),
	valorCanje(ColeccionistaB, ColeccionistaA, PuntajeB),
	PuntajeA > PuntajeB.

canjesRealizados(Coleccionista,OtrosColeccionistas):-
	(findall(Persona,obtuvoEn(canje,Coleccionista,_,Persona,_),OtrosColeccionistas);
	findall(Persona,obtuvoEn(canje,Persona,_,Coleccionista,_),OtrosColeccionistas)),
	OtrosColeccionistas \= [].

%-----------------------------------------------------------------------------
%   Punto 8: hizoNegocio
%-----------------------------------------------------------------------------
albumCompleto(Figuritas):- findall(Figurita,figurita(Figurita,_),Figuritas).

figuritasFaltantes(Coleccionista,Figurita):-
	coleccionista(Coleccionista),
	albumCompleto(FiguritasAlbum),
	member(Figurita,FiguritasAlbum),
	\+figuritasObtenidas(Coleccionista, Figurita).

necesitaFigurita(Coleccionista,Figurita):-
	tieneParteDelRompecabeza(Coleccionista, Figurita).

necesitaFigurita(Coleccionista,Figurita):-
	figurita(Figurita),
	findall(FiguritaFaltante, figuritasFaltantes(Coleccionista, FiguritaFaltante), FiguritasFaltantes),
	length(FiguritasFaltantes, 1),
	member(Figurita,FiguritasFaltantes).

tieneParteDelRompecabeza(Persona, Figurita) :-
  figuritasFaltantes(Persona, Figurita),
  figurita(Figurita, rompecabezas(Imagen)),
  findall(FiguritaObtenida,figuritasObtenidas(Persona, FiguritaObtenida), Obtenidas),
  member(Otra, Obtenidas),
  figurita(Otra, rompecabezas(Imagen)),
  Otra \= Figurita.	

%-----------------------------------------------------------------------------
%   Punto 9: hizoNegocio
%-----------------------------------------------------------------------------

/* 
posiblesCanjes2: El siguinte predicado asocia a: 
      Coleccionista: Persona que tiene figuritas.
      FiguritaBuscada: Figuritas que necesita ya sea para completar album o completar parte del rompecabeaz que tiene.
      FiguritasQueEntregaria: Solo esta dispuesto a entregar figuritas que tiene repetidas.
      Interesado: Persona que busca las figuritas repetidas por el Coleccionista y no las consiguio por ningun medio.
    
Ejecutar en consola: 
posiblesCanjes(Coleccionista,FiguritaBuscada,FiguritasQueEntregaria,Interesado).
*/
posiblesCanjes(Persona,FiguritaBuscada,FiguritasQueEntregaria,Interesado):-
	coleccionista(Persona),
	coleccionista(Interesado),
	findall(Figurita,figuritasObtenidas(Interesado, Figurita),FiguritasDelInteresado), 
	Persona \= Interesado,
	findall(Figurita,necesitaFigurita(Persona,Figurita),FiguritasQueNecesita),
	member(FiguritaBuscada,FiguritasQueNecesita),
	member(FiguritaBuscada,FiguritasDelInteresado),
	findall(Figurita,figuritaRepetida(Persona,Figurita),FiguritasQueEntregaria),
	figuritasFaltantes(Interesado,FiguritaBuscadaPorInteresado),
	member(FiguritaBuscadaPorInteresado,FiguritasQueEntregaria),
	estaDispuestoAlCanje(Interesado,FiguritaBuscada,FiguritasQueEntregaria).

% A) No tiene ninguna de las figuritas que recibiría
estaDispuestoAlCanje(Interesado,_,FiguritasARecibir):-
	figuritasFaltantes(Interesado,Figurita),
	member(Figurita, FiguritasARecibir).

% B) Sólo estaría entregando figuritas repetidas
estaDispuestoAlCanje(Interesado,FiguritaADar,_):-
	figuritaRepetida(Interesado, FiguritaADar).

% C) Alguna de las figuritas que recibiría es valiosa
estaDispuestoAlCanje(_,_,FiguritasARecibir):-
	member(Figurita, FiguritasARecibir),
	figuritaValiosa(Figurita).

%C ) Recibiría al menos una figurita que necesita
estaDispuestoAlCanje(Interesado,_,FiguritasARecibir):-
	member(Figurita, FiguritasARecibir),
	necesitaFigurita(Interesado,Figurita).
%shell(clear).