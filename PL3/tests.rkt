(load "pl3.rkt")

(display "(comprobar-lista ((concatenar lista-1) lista-2))") (newline)
(comprobar-lista ((concatenar lista-1) lista-2))

(display "(comprobar-lista ((concatenar lista-2) lista-1))") (newline)
(comprobar-lista ((concatenar lista-2) lista-1))

(display "(comprobar (longitud lista-2))") (newline)
(comprobar (longitud lista-2))

(display "(comprobar-lista (invertir lista-3))") (newline)
(comprobar-lista (invertir lista-3))

(display "((pertenece? dos) lista-2)") (newline)
((pertenece? dos) lista-2)

(display "((pertenece? dos) lista-1)") (newline)
((pertenece? dos) lista-1)

(display "(testenteros (sumar lista-2))") (newline)
(testenteros (sumar lista-2))

(display "(testenteros (maximo lista-4))") (newline)
(testenteros (maximo lista-4))

(display "(testenteros (minimo lista-4))") (newline)
(testenteros (minimo lista-4))

(display "(comprobar-lista (ordenar lista-4))") (newline)
(comprobar-lista (ordenar lista-4))

(display "(comprobar-lista ((sumar-listas lista-2) lista-2))") (newline)
(comprobar-lista ((sumar-listas lista-2) lista-2))