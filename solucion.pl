/* Solución TP Lógico 2025 */

obtuvoEn(paquete,andy,1,2).
obtuvoEn(paquete,andy,1,4).
obtuvoEn(paquete,andy,2,6).
obtuvoEn(paquete,andy,2,7).
obtuvoEn(paquete,andy,3,1).
obtuvoEn(paquete,andy,3,5).
obtuvoEn(paquete,andy,3,8).
obtuvoEn(paquete,flor,1,5).
obtuvoEn(paquete,flor,2,5).
% obtuvoEn(paquete,flor,2,8). %agregado para prueba.
% obtuvoEn(paquete,flor,2,8). %agregado para prueba.
obtuvoEn(paquete,bobby,1,3).
obtuvoEn(paquete,bobby,1,5).
obtuvoEn(paquete,bobby,2,7).
% obtuvoEn(paquete,bobby,2,8). %agregado para prueba.
obtuvoEn(paquete,lala,1,1).
obtuvoEn(paquete,lala,1,3).
obtuvoEn(paquete,lala,1,7).
obtuvoEn(paquete,toto,1,1).
% obtuvoEn(paquete,toto,2,8). %agregado para prueba.
obtuvoEn(paquete,emi,1,9).
obtuvoEn(paquete,emi,1,10).
obtuvoEn(paquete,emi,2,9).
obtuvoEn(paquete,emi,2,10).
% obtuvoEn(paquete,emi,2,8). %agregado para prueba.
obtuvoEn(canje,pablito,6,toto).
obtuvoEn(canje,toto,2,pablito).
obtuvoEn(canje,pablito,1,lala).
obtuvoEn(canje,lala,5,pablito).
obtuvoEn(canje,emi,3,lala).
obtuvoEn(canje,lala,9,emi).
obtuvoEn(canje,emi,2,toto).
obtuvoEn(canje,toto,10,emi).
obtuvoEn(canje,flor,2,bobby).
obtuvoEn(canje,bobby,1,flor).
obtuvoEn(canje,bobby,4,flor).
obtuvoEn(canje,bobby,6,flor).
obtuvoEn(canje,andy,1,flor).
obtuvoEn(canje,flor,4,andy).
obtuvoEn(canje,flor,7,andy).

%Predicados generadores
figurita(Figurita):-
    findall(F,figurita(F,_),Figuritas),
    sort(Figuritas, FiguritasSinRepetir),
    member(Figurita, FiguritasSinRepetir).
    
coleccionista(Coleccionista):-
    findall(Persona,figuritasObtenidas(Persona,_),Personas),
    sort(Personas, Coleccionistas),
    member(Coleccionista, Coleccionistas).
    
%-----------------------------------------------------------------------------
%   Punto 1 : figuritasObtenidas/2
%-----------------------------------------------------------------------------

figuritasObtenidas(Persona,Figurita):-
    obtuvoEn(paquete,Persona,_,Figurita);
    obtuvoEn(canje,Persona,Figurita,_).

% figuritasObtenidas(Persona,Figurita):-
%     obtuvoEn(canje,Persona,Figurita,_).

%Comentado por ahora por inconsistencias con la consigna.
% figuritasObtenidas(Persona,Figurita):-
%     obtuvoEn(canje,_,Figurita,Persona).


%-----------------------------------------------------------------------------
%   Punto 2 : figuritaRepetida/2
%-----------------------------------------------------------------------------

figuritaRepetida(Persona,Figurita):-
    coleccionista(Persona),
    findall(F, figuritasObtenidas(Persona, F), Figuritas),
    include(duplicado(Figuritas), Figuritas, Repetidas),
    sort(Repetidas, Unicas),
    member(Figurita,Unicas).
  
duplicado(Figuritas,Figurita):-
    select(Figurita,Figuritas,RestoFiguritas),
    member(Figurita,RestoFiguritas).

%-----------------------------------------------------------------------------
%   Punto 3 : figuritaRara/1
%-----------------------------------------------------------------------------

figuritaRara(Figurita):-
    figurita(Figurita),
    findall(F,(obtuvoEn(paquete,_,Numero,F), Numero =< 2),Figuritas),
    not(member(Figurita,Figuritas)).

figuritaRara(Figurita):-
    obtuvoEn(canje,PersonaA,Figurita,PersonaB),
    findall(F,obtuvoEn(canje,PersonaB,F,PersonaA),Figuritas),
    length(Figuritas, CantidadRecibida),
    CantidadRecibida >=3.

figuritaRara(Figurita):-
    figurita(Figurita),
    findall(Persona, figuritasObtenidas(Persona,Figurita), Personas),
    length(Personas, CantidadPersonasQueLatienen),
    findall(Coleccionista, coleccionista(Coleccionista), Coleccionistas),
    length(Coleccionistas, CantidadDeColeccionistas),
    CantidadPersonasQueLatienen < (CantidadDeColeccionistas / 2),
    not(figuritaRepetida(_,Figurita)).

%-----------------------------------------------------------------------------
%   Punto 4 : personajes(nombre,popularidad)
%-----------------------------------------------------------------------------

figurita(1,basica(personaje(kitty,5))).
figurita(1,basica(personaje(keroppi,3))).
figurita(2,brillante(personaje(kitty,5))).
figurita(3,brillante(personaje(myMelody,3))).
figurita(4,basica(escenario)).
figurita(5,rompecabezas(restaurante)).
figurita(6,rompecabezas(restaurante)).
figurita(7,rompecabezas(restaurante)).
figurita(8,basica(personaje(kitty,5))).
figurita(8,basica(personaje(cinnamoroll,4))).
figurita(8,basica(personaje(badtzMaru,2))).
figurita(8,basica(personaje(keroppi,3))).
figurita(8,basica(personaje(pompompurin,4))).
figurita(8,basica(personaje(gudetama,1))).
figurita(8,basica(personaje(myMelody,3))).
figurita(8,basica(personaje(littleTwinStars,2))).
figurita(8,basica(personaje(kuromi,5))).
figurita(9,basica(escenario)).
figurita(10,basica(escenario)).

figuritaBrillante(Figurita):-
    figurita(Figurita,brillante(_)).

figuritaBasica(Figurita):-
    figurita(Figurita,basica(_)).

figuritaDeRompecabezas(Tipo,Figurita):-
    figurita(Figurita,rompecabezas(Tipo)).

%-----------------------------------------------------------------------------
%   Punto 5 : figuritaValiosa/1
%-----------------------------------------------------------------------------

figuritaValiosa(Figurita) :-
    figuritaRara(Figurita).

figuritaValiosa(Figurita) :-
    nivelDeAtractivo(Figurita,Atractivo),
    Atractivo > 7.

nivelDeAtractivo(Figurita,Atractivo):-
    figurita(Figurita,brillante(personaje(_,Popularidad))),
    Atractivo is Popularidad * 5.

nivelDeAtractivo(Figurita,Atractivo):-
    findall(Pop, figurita(Figurita,basica(personaje(_,Pop))), Popularidades),
    sumlist(Popularidades, Atractivo).
    

nivelDeAtractivo(Figurita,2):-
    figurita(Figurita,rompecabezas(Tipo)),
    cantidadDePiezasRompecabezas(Tipo,Cantidad),
    Cantidad =< 2.

nivelDeAtractivo(Figurita,0):-
    figurita(Figurita,rompecabezas(Tipo)),
    cantidadDePiezasRompecabezas(Tipo,Cantidad),
    Cantidad > 2.

cantidadDePiezasRompecabezas(Tipo,Cantidad):-
    findall(Figurita,figuritaDeRompecabezas(Tipo,Figurita),Figuritas),
    length(Figuritas,Cantidad).
    
    
%shell(clear).