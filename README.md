# Trabajo Práctico de Lógico 2025 : Figuritas

## Predicados principales

### Punto 1: `figuritasObtenidas/2`

**Descripción:**  
Relaciona una persona con las figuritas obtenidas.

**Objetivo:**  
Determinar qué figuritas tiene una persona.  
Una persona tiene una figurita si fue **recibida en un canje** o **sacada de un paquete**.

> **Nota importante:**  
> - **No importan las figuritas que entregó en un canje**, eso quedó en el pasado.  
> - Se considera que una persona tiene **todas las figuritas que alguna vez obtuvo**, incluso si luego entregó esa misma figurita en otro canje.

**Uso esperado:**

```prolog
% figuritasObtenidas(Coleccionista,Figurita).
?- figuritasObtenidas(bobby,Figurita).
F = 3 ;
F = 5 ;
F = 7 ;
F = 1 ;
F = 4 ;
F = 6 ;
F = 2.
```
### Punto 2: `figuritaRepetida/2:`
**Descripción:**  
Relaciona una persona con las figuritas repetidas.

**Objetivo:**  
Determinar qué figuritas tiene repetida una persona.  

**Uso esperado:**

```prolog
% figuritaRepetida(Persona,FiguritaRepetida).
?- figuritaRepetida(andy,Figurita).
Figurita = 1 ;
Figurita = 4 ;
Figurita = 7 ;
false.
``` 
### Punto 3: `figuritaRara/1:`
**Objetivo:**  
Determinar si una figurita es rara.

**Condiciones:**
- Nadie la consiguió en los primeros 2 paquetes que abrió.
- Alguien la consiguió en un canje en el cual sólo recibió esa figurita dando a cambio por lo menos 3 figuritas propias.
- Menos de la mitad de las personas que coleccionan las figuritas la consiguieron, y nadie la tiene repetida.
```prolog
?- figuritaRara(Figurita).
Figurita = 8 ;
Figurita = 2 ;
Figurita = 8 ;
false.
``` 

### Punto 4
Incorporar a la base de conocimientos la siguiente información sobre la imagen de las figuritas:

- La 1 es una figurita básica que incluye a los personajes kitty y keroppi.
- La 2 es una figurita brillante y aparece kitty. 
- La 3 es una figurita brillante y aparece myMelody.
- La 4 es una figurita básica que no incluye a ningún personaje.
- Hay 3 figuritas que conforman un rompecabezas de un restaurante: son la 5, la 6 y la 7.
- La 8 es una figurita básica que incluye a todos los personajes de la franquicia.
- Las figuritas 9 y 10 son básicas y sin personajes (tienen escenarios).

### Punto 5: `figuritaValiosa/1:`
**Objetivo:**  
Determinar si una figurita es Valiosa.

**Condiciones:**
- Se cumple si es una figurita rara.
- Si el nivel de atractivo de su imagen es mayor a 7.
    - Si se trata de una **figurita brillante**, su atractivo es 5 multiplicado por la popularidad del personaje de la imagen.
    - Si se trata de una **figurita básica** es la suma de la popularidad de cada personaje que aparezca.
```prolog
% figuritaRara(NumeroFigurita).
?- figuritaRara(Figurita).
Figurita = 8 ;
Figurita = 2 ;
Figurita = 8 ;
false.
``` 
### Punto 6: `valorPaquete/3:` y `valorCanje/3:`
**Objetivo:**  
Dado un paquete abierto o un canje realizado por una persona, saber qué tan interesante fue lo que obtuvo, que se calcula como la sumatoria del atractivo de las imágenes de las figuritas que consiguió por ese medio.

**Nota:**
- Más un plus de 20 puntos si allí consiguió alguna figurita rara. 
```prolog
%valorPaquete(Persona,NúmeroPaquete,Valor).
valorPaquete(lala,1,Valor).
Valor = 43 .
``` 
```prolog
%valorCanje(PersonaA,PersonaB, Valor).
?- valorCanje(pablito,toto,Valor).
Valor = 45 .
``` 