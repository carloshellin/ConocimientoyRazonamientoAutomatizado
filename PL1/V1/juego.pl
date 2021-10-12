:-consult('conocimiento.pl').

% Obtener la longitud de una lista

list_longitud([_|Resto], N):- list_longitud(Resto, N1), N is N1 + 1.
list_longitud([], N):- N is 0.


% caracteristica(X,Caracteristica) cierta si Caracteristica(X) es cierta. Por ejemplo, caracteristica(X,chico) cierta si X es chico.
caracteristica(Personaje, Caracteristica):-
    caracteristicas(Lista),
    member(Caracteristica, Lista),
    Z=..[Caracteristica, Personaje],
    call(Z).


% Lista de caracteristicas

lista_caracteristicas(Personaje, Caracteristicas):-
    lista_caracteristicas_aux(Personaje, [], Lista),
    reverse(Lista, Caracteristicas).

lista_caracteristicas_aux(Personaje, Lista, Caracteristicas):-
    caracteristica(Personaje, Caracteristica),
    not(member(Caracteristica, Lista)),
    lista_caracteristicas_aux(Personaje, [Caracteristica|Lista], Caracteristicas).

lista_caracteristicas_aux(_, Lista, Lista).


% Lista de candidatos

xor(A,B) :- (A;B), not((A,B)).

candidatos_aux(PersonajeInicial, Caracteristica, Lista, [Personaje|Resto], NuevosCandidatos):-
    not(member(Personaje, Lista)),
    A = caracteristica(PersonajeInicial, Caracteristica),
    B = caracteristica(Personaje, Caracteristica),
    (xor(A,B) ->
        candidatos_aux(PersonajeInicial, Caracteristica, Lista, Resto, NuevosCandidatos)
        ;
        candidatos_aux(PersonajeInicial, Caracteristica, [Personaje|Lista], Resto, NuevosCandidatos)).
candidatos_aux(_, _, Lista, _, Lista).

candidatos(PersonajeInicial, Caracteristica, Candidatos, NuevosCandidatos):-
    candidatos_aux(PersonajeInicial, Caracteristica, [], Candidatos, NuevosCandidatos).


% Mostrar los candidatos, el personaje con sus características

imprimir_candidatos([Personaje|Candidatos]):-
    lista_caracteristicas(Personaje, Caracteristicas),
    writeln([Personaje|Caracteristicas]),
    imprimir_candidatos(Candidatos).
imprimir_candidatos(_).


% Lista de preguntas

preguntas_aux([Caracteristica|Resto]):- write('?, '), write(Caracteristica), preguntas_aux(Resto).
preguntas_aux([]).

preguntas :-
    caracteristicas(Caracteristicas),
    [Caracteristica|Resto]=Caracteristicas,
    write(Caracteristica), preguntas_aux(Resto), writeln('?').


% Se elijen los personajes aleatorios de cada jugador
    
personajes_aleatorio(Personaje1, Personaje2) :-
     personajes(Personajes),
     random_member(Personaje1, Personajes),
     random_member(Personaje2, Personajes).


% Elimina la duplicidad de preguntas ya realizadas y sus antónimos
     
eliminar_duplicidad(Personaje1, Pregunta, Preguntas, NuevasPreguntas) :-
     select(Pregunta, Preguntas, Resto),
     lista_caracteristicas(Pregunta, Antonimos),
     list_longitud(Antonimos, N),
     ((caracteristica(Personaje1, Pregunta) ; N = 1) ->
         subtract(Resto, Antonimos, NuevasPreguntas)
     ;
         NuevasPreguntas = Resto
     ).


% Cada turno, un personaje realiza una acción

accion(Personaje, Candidatos, NuevosCandidatos) :-
    preguntas,

    read(Caracteristica), nl,

    write('La respuesta a la pregunta es'),
    (caracteristica(Personaje, Caracteristica) -> write(' afirmativa') ; write(' negativa')),
    writeln('.'), nl,

    writeln('Ya sabes que soy uno de los personajes de la siguiente lista:'),
    candidatos(Personaje, Caracteristica, Candidatos, NuevosCandidatos),
    imprimir_candidatos(NuevosCandidatos), nl.


% Bucle del juego contra ordenador que gestiona el desarrollo del juego

desarrollo(_, _, [Personaje2|[]], [Personaje1|[]], _) :-
    write('Hay empate. Ya sabes que soy '), write(Personaje2), write(' y tú eres '), writeln(Personaje1).
desarrollo(_, _, [Personaje2|[]], _, _) :-
    write('Has ganado. Ya sabes que soy '), writeln(Personaje2).
desarrollo(_, _, _, [Personaje1|[]], _) :-
    write('Has perdido. Sé que eres '), writeln(Personaje1).
    
desarrollo(Personaje1, Personaje2, Candidatos1, Candidatos2, Preguntas) :-
    writeln('Elige de entre las siguientes preguntas una que quieras hacerme y escríbela cambiando la interrogación por un punto:'),
    accion(Personaje2, Candidatos1, NuevosCandidatos1),

    writeln('Ahora te hago yo una pregunta:'),
    estrategia(Personaje1, Candidatos2, Pregunta, Preguntas, NuevasPreguntas), write(Pregunta), writeln('?'),

    write('La respuesta a la pregunta es'),
    (caracteristica(Personaje1, Pregunta) ->
        write(' afirmativa')
    ;
        write(' negativa')),
    write('. '),

    candidatos(Personaje1, Pregunta, Candidatos2, NuevosCandidatos2),
    list_longitud(NuevosCandidatos2, N),
    write('Por lo tanto, aún dudo entre '), write(N), writeln(' posibilidades.'),
    
    desarrollo(Personaje1, Personaje2, NuevosCandidatos1, NuevosCandidatos2, NuevasPreguntas).


% Se juega contra el ordenador con estrategia random

medio :-
    consult('estrategia_random.pl'),
    jugar.


% Se juega contra el ordenador con estrategia mitad

avanzado :-
    consult('estrategia_mitad.pl'),
    jugar.


% Prepara el juego y llama a desarrollo

jugar :-
    personajes_aleatorio(Personaje1, Personaje2),
    write('Tu personaje es '), write(Personaje1), writeln('.'), nl,
      
    writeln('Te recuerdo sus características:'),
    lista_caracteristicas(Personaje1, List_caracts),
    writeln(List_caracts), nl,
      
    personajes(Candidatos),
    caracteristicas(Preguntas),
    desarrollo(Personaje1, Personaje2, Candidatos, Candidatos, Preguntas).
    

% Bucle del juego jugador contra jugador que gestiona el desarrollo del juego

desarrollo_jugador(_, _, [Personaje2|[]], [Personaje1|[]]) :-
    write('Hay empate. El jugador 1 es '), write(Personaje1), write(' y el jugador 2 es '), writeln(Personaje2).
desarrollo_jugador(_, _, [Personaje2|[]], _) :-
    write('Ha ganado el jugador 1. El jugador 2 es '), writeln(Personaje2).
desarrollo_jugador(_, _, _, [Personaje1|[]]) :-
    write('Ha ganado el jugador 2. El jugador 1 es '), writeln(Personaje1).

desarrollo_jugador(Personaje1, Personaje2, Candidatos1, Candidatos2) :-
    writeln('JUGADOR 1:'),
    writeln('Elige de entre las siguientes preguntas una que quieras hacer y escríbela cambiando la interrogación por un punto:'),
    accion(Personaje2, Candidatos1, NuevosCandidatos1),
     
    writeln('JUGADOR 2:'),
    writeln('Elige de entre las siguientes preguntas una que quieras hacer y escríbela cambiando la interrogación por un punto:'),
    accion(Personaje1, Candidatos2, NuevosCandidatos2),

    desarrollo_jugador(Personaje1, Personaje2, NuevosCandidatos1, NuevosCandidatos2).
    

% Muestra el personaje y sus características al jugador
    
mostrar_personaje(Personaje) :-
    write(Personaje), writeln('.'), nl,
    writeln('Te recuerdo sus características:'),
    lista_caracteristicas(Personaje, List_caracts1),
    writeln(List_caracts1), nl.


% Prepara el juego para jugador contra jugador y llama a desarrollo_jugador

jugar_jugador :-
    personajes_aleatorio(Personaje1, Personaje2),
    writeln('JUGADOR 1:'),
    write('El personaje del jugador 1 es '),
    mostrar_personaje(Personaje1),
    
    writeln('JUGADOR 2:'),
    write('El personaje del jugador 2 es '),
    mostrar_personaje(Personaje2),

    personajes(Candidatos),
    desarrollo_jugador(Personaje1, Personaje2, Candidatos, Candidatos).
