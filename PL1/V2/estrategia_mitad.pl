% Estrategia mitad

% Intercambia la posición (índice) de una lista por el elemento

reemplazar(Indice, Lista, NuevaLista, Elemento) :-
    reemplazar_aux(Indice, Lista, _, NuevaLista, Elemento).

reemplazar_aux(Indice, Lista, Eliminado, NuevaLista, Elemento) :-
    length(Inicio, Indice),
    append(Inicio, [Eliminado|Final], Lista),
    append(Inicio, [Elemento|Final], NuevaLista).


% Crea una lista con un elemento repetido N veces

crear_lista(_, 0, Lista, Lista).

crear_lista(Elemento, N, Lista, NuevaLista) :-
    N1 is N-1,
    crear_lista(Elemento, N1, [Elemento|Lista], NuevaLista).


% Se inician los contadores a 0 de N preguntas para la estrategia

iniciar_contadores(Contadores, Preguntas) :-
    list_longitud(Preguntas, N),
    crear_lista(0, N, [], Contadores).


% Se cuentan las características de los candidatos del ordenador para la estrategia

contar_caracteristicas(_, [], Contadores, Contadores).

contar_caracteristicas(Caracteristicas, [Caracteristica|Resto], Contadores, ContadoresFinal) :-
    nth0(Indice, Caracteristicas, Caracteristica),
    nth0(Indice, Contadores, Valor),
    Valor1 is Valor + 1,
    reemplazar(Indice, Contadores, NuevosContadores, Valor1),
    contar_caracteristicas(Caracteristicas, Resto, NuevosContadores, ContadoresFinal).


% Se crean contadores para usarlos a la hora de contar las características

crear_contadores(_, Contadores, Contadores, []).

crear_contadores(Caracteristicas, Contadores, ContadoresFinal, [Candidato|Candidatos]) :-
    lista_caracteristicas(Candidato, CandidatoCaracteristicas),
    contar_caracteristicas(Caracteristicas, CandidatoCaracteristicas, Contadores, NuevosContadores),
    crear_contadores(Caracteristicas, NuevosContadores, ContadoresFinal, Candidatos).


% Búsqueda secuencial para encontrar la característica que tiene la mitad de candidatos

busqueda_secuencial([], _, _, _, Indice, Indice).

busqueda_secuencial([Contador|Contadores], Mitad, Valor, Posicion, Indice, IndiceFin) :-
    abs(Contador - Mitad, Resultado),
    Posicion1 is Posicion + 1,
    (Resultado < Valor ->
        busqueda_secuencial(Contadores, Mitad, Resultado, Posicion1, Posicion1, IndiceFin)
    ;
        busqueda_secuencial(Contadores, Mitad, Valor, Posicion1, Indice, IndiceFin)
    ).


% Estrategia mitad

estrategia(Personaje1, Candidatos, Pregunta, Preguntas, NuevasPreguntas) :-
    iniciar_contadores(Contadores, Preguntas),
    crear_contadores(Preguntas, Contadores, ContadoresFinal, Candidatos),

    list_longitud(Candidatos, N),
    Mitad = N / 2,
    ContadoresFinal = [Valor|Resto],
    busqueda_secuencial(Resto, Mitad, Valor, 0, 0, IndiceFin),

    nth0(IndiceFin, Preguntas, Pregunta),
    eliminar_duplicidad(Personaje1, Pregunta, Preguntas, NuevasPreguntas).
