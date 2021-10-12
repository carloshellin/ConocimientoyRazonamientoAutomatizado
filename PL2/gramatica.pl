% Reglas gramaticales
oracion --> g_nominal, g_verbal.
g_nominal --> nombre.
g_nominal --> determinante, nombre.
g_nominal --> preposicion, nombre.
g_nominal --> preposicion, g_nominal.
g_nominal --> determinante, nombre, adjetivo.
g_nominal --> nombre, adjetivo.
g_verbal --> verbo.
g_verbal --> verbo, g_nominal.
g_verbal --> verbo, adjetivo.

%Diccionario
determinante --> [el].
determinante --> [la].
determinante --> [un].
determinante --> [una].

preposicion --> [a].
preposicion --> [en].

nombre --> [hombre].
nombre --> [mujer].
nombre --> [juan].
nombre --> [maría].
nombre --> [manzana].
nombre --> [manzanas].
nombre --> [gato].
nombre --> [ratón].
nombre --> [ratones].
nombre --> [alumno].
nombre --> [universidad].

verbo --> [ama].
verbo --> [come].
verbo --> [estudia].
verbo --> [es].

adjetivo --> [roja].
adjetivo --> [negro].
adjetivo --> [grande].
adjetivo --> [gris].
adjetivo --> [pequeño].
