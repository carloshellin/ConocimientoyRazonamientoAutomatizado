% Estrategia random

estrategia(Personaje1, _, Pregunta, Preguntas, NuevasPreguntas) :-
    random_member(Pregunta, Preguntas),
    eliminar_duplicidad(Personaje1, Pregunta, Preguntas, NuevasPreguntas).
