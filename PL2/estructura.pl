:-consult(draw).

o_compleja(oracion(ORACION)) --> o_coordinada(ORACION).
o_compleja(oracion(ORACION)) --> o_compuesta(ORACION).

o_simple(o(GN,GV)) --> g_nominal(GN), g_verbal(GV).
o_simple(o(GV)) --> g_verbal(GV).

o_coordinada(oc(O1,CONJ,O2)) --> o_simple(O1), nexo(CONJ), o_simple(O2).
o_coordinada(oc(O,CONJ,OC)) --> o_simple(O), nexo(CONJ), o_coordinada(OC).

o_subordinada(or(CONJ,O)) --> nexo(CONJ), o_simple(O).

o_compuesta(ocm(OC,CONJ,O)) --> o_coordinada(OC), nexo(CONJ), o_simple(O).
o_compuesta(ocm(GN,OR,O1,CONJ,O2)) --> g_nominal(GN), o_subordinada(OR), o_simple(O1), nexo(CONJ), o_simple(O2).
o_compuesta(ocm(GN,OR,O)) --> g_nominal(GN), o_subordinada(OR), o_simple(O).

g_nominal(gn(GN)) --> g_nom(GN).
g_nominal(gn(GN,GP)) --> g_nom(GN), g_preposicional(GP).
g_nominal(gn(GN1,CONJ,GN2)) --> g_nom(GN1), nexo(CONJ), g_nom(GN2).

g_nom(gn(N)) --> nombre(N).
g_nom(gn(N)) --> nombre_propio(N).
g_nom(gn(N,GAdj)) --> nombre(N), g_adjetival(GAdj).
g_nom(gn(D,N)) --> determinante(D), nombre(N).
g_nom(gn(D,N,GAdj)) --> determinante(D), nombre(N), g_adjetival(GAdj).

g_adjetival(gadj(ADJ)) --> adjetivo(ADJ).
g_adjetival(gadj(ADV, GADJ)) --> adverbio(ADV), g_adjetival(GADJ).

g_adverbial(gadv(Adv)) --> adverbio(Adv).
g_adverbial(gadv(Adv, GAdv)) --> adverbio(Adv), g_adverbial(GAdv).

g_preposicional(gprep(P,GN)) --> preposicion(P), g_nominal(GN).
g_preposicional(gprep(P,INF,GN)) --> preposicion(P), infinitivo(INF), g_nominal(GN).

g_verbal(gv(V,GN)) --> verbo(V), g_nominal(GN).
g_verbal(gv(V)) --> verbo(V).
g_verbal(gv(V,GAdj)) --> verbo(V), g_adjetival(GAdj).
g_verbal(gv(V,GAdv)) --> verbo(V), g_adverbial(GAdv).
g_verbal(gv(V,GP)) --> verbo(V), g_preposicional(GP).
g_verbal(gv(V,GP1,GP2)) --> verbo(V), g_preposicional(GP1), g_preposicional(GP2).
g_verbal(gv(V,GAdv,GP)) --> verbo(V), g_adverbial(GAdv), g_preposicional(GP).
g_verbal(gv(V,GN,GP)) --> verbo(V), g_nominal(GN), g_preposicional(GP).
g_verbal(gv(GAdv,V,GP)) --> g_adverbial(GAdv), verbo(V), g_preposicional(GP).
g_verbal(gv(V,GAdv,GN)) --> verbo(V), g_adverbial(GAdv), g_nominal(GN).

nexo(nx(CONJ)) --> conjuncion(CONJ).
nexo(nx(REL)) --> relativo(REL).

determinante(det(X)) --> [X],{det(X)}.
det(el).
det(la).
det(un).
det(una).
det(mi).
det(esta).
det(su).
det(las).

nombre(n(X)) --> [X],{n(X)}.
n(hombre).
n(mujer).
n(manzana).
n(manzanas).
n(gato).
n(ratón).
n(ratones).
n(alumno).
n(universidad).
n(tenedor).
n(cuchillo).
n(práctica).
n(casa).
n(enfermero).
n(desierto).
n(todos).
n(clase).
n(noche).
n(esperanza).
n(vida).
n(niño).
n(lugar).
n(nacimiento).
n(pelo).
n(filosofía).
n(derecho).
n(café).
n(mesa).
n(periódico).
n(patatas).
n(cerveza).
n(paella).
n(novela).
n(zumo).
n(rocódromo).
n(tardes).
n(procesador).
n(textos).
n(herramienta).
n(documentos).
n(vecino).

nombre_propio(np(X)) --> [X],{np(X)}.
np(juan).
np(maría).
np(ana).
np(madrid).
np(alcalá).
np(héctor).
np(irene).

verbo(v(X)) --> [X],{v(X)}.
v(come).
v(comen).
v(ama).
v(estudia).
v(es).
v(hace).
v(está).
v(fue_ayudada).
v(llueve).
v(comportaron).
v(saldré).
v(depende).
v(tiene).
v(bebe).
v(lee).
v(tiene).
v(se_comportan).
v(toma).
v(recoge).
v(beben).
v(prefiere).
v(canta).
v(salta).
v(escala).
v(sirve).
v(cazó).
v(era).
v(vimos).

infinitivo(inf(X)) --> [X],{inf(X)}.
inf(escribir).

adjetivo(adj(X)) --> [X],{adj(X)}.
adj(roja).
adj(negro).
adj(grande).
adj(gris).
adj(pequeño).
adj(moreno).
adj(alta).
adj(alto).
adj(rubio).
adj(morena).
adj(fritas).
adj(ágil).
adj(delicado).
adj(rojas).
adj(potente).
adj(lento).

adverbio(adv(X)) --> [X],{adv(X)}.
adv(muy).
adv(lejos).
adv(nunca).
adv(bien).
adv(solamente).
adv(bastante).
adv(ayer).

conjuncion(conj(X)) --> [X],{conj(X)}.
conj(y).
conj(mientras).
conj(pero).
conj(aunque).
conj(e).

relativo(rel(X)) --> [X],{rel(X)}.
rel(que).

preposicion(prep(X)) --> [X],{prep(X)}.
prep(a).
prep(en).
prep(con).
prep(de).
prep(por).
prep(de).
prep(para).

simplificar([],_).
simplificar(L, SUJETO):- (L=[_|[]] ->
                             L=[L2|L3],
                             D = nada
                             ;
                             L=[D,L2|L3]),
                         (o_subordinada(D,_,_) ->
                             D=..[_,_,A|_],
                             (o_simple(A,_,_) ->
                                 A=..[_,S|_],
                                 (g_nominal(S,_,_) ->
                                      writeln(A),
                                      L=[_|L4],
                                      simplificar(L4, S)
                                  ;
                                      agregar_sujeto(SUJETO, A, FRASE),
                                      writeln(FRASE),
                                      L=[_|L4],
                                      simplificar(L4, SUJETO)
                                  )
                              )
                         ;
                             (o_simple(D,_,_) ->
                                 D=..[_,S|_],
                                 (g_nominal(S,_,_) ->
                                      writeln(D),
                                      L=[_|L4],
                                      simplificar(L4, S)
                                  ;
                                      agregar_sujeto(SUJETO, D, FRASE),
                                      writeln(FRASE),
                                      L=[_|L4],
                                      simplificar(L4, SUJETO)
                                  )
                              ;
                                 (o_simple(L2,_,_) ->
                                     L2=..[_,S|_],
                                     (g_nominal(S,_,_) ->
                                          writeln(L2),
                                          simplificar(L3, S)
                                      ;
                                          agregar_sujeto(SUJETO, L2, FRASE),
                                          writeln(FRASE),
                                          simplificar(L3, SUJETO)
                                      )
                                 ;
                                     (g_nominal(L2,_,_) ->
                                          simplificar(L3, L2)
                                     ;
                                          L2=..L4,
                                          append(L4,L3,L5),
                                          simplificar(L5, SUJETO)
                                     )
                                 )
                              )
                         ).

agregar_sujeto(SUJ, RESTO, FIN):- SUJ=..LSUJ,
                                  LSUJ=[_|LSUJ1],
                                  RESTO=..[INI|LRESTO],
                                  INI=..LINI,
                                  append(LINI,LSUJ1,X),
                                  append(X,LRESTO,LFIN),
                                  FIN=..LFIN.

contar([ELEM|RESTO], CONT, FIN, PRED):- Z=..[PRED, ELEM],
                                        (call(Z) ->
                                            CONT1 is CONT + 1,
                                            contar(RESTO, CONT1, FIN, PRED)
                                        ;
                                            contar(RESTO, CONT, FIN, PRED)).
contar([], CONT, CONT, _).

datos(O, VERBOS):- writeln('************ DATOS DE LA ORACIÓN ************'),
                   writeln(''),
                   contar(O, 0, VERBOS, v),
                   write('Número de verbos: '),
                   writeln(VERBOS),
                   contar(O, 0, RELATIVOS, rel),
                   write('Número de conjunciones de relativo: '),
                   writeln(RELATIVOS),
                   contar(O, 0, CONJUNCIONES, conj),
                   write('Número de nexos: '),
                   writeln(CONJUNCIONES),
                   writeln(''),
                   writeln('*********************************************').
                   
analizar(O):- datos(O,V),
              (V = 1 ->
                  o_simple(X,O,[]),
                  writeln(X),
                  draw(X),
                  writeln(X)
              ;
                  o_compleja(X,O,[]),
                  writeln(X),
                  draw(X),
                  X=..Y,
                  simplificar(Y,[])).
