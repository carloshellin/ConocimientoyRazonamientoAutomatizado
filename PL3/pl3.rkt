(load "enteros.rkt")

; Concatenación.
(define concatenar
    (lambda (l1)
        (lambda (l2)
            (((Y (lambda (f)
                   (lambda (x)
                     (lambda (y)
                      (((vacia? x)
                       (lambda (no_use)
                            y
                        )
                       (lambda (no_use)
                            ((construir (cabeza x)) ((f (cola x)) y))
                        )
               
                    )
                        zero)  ; Pasa zero como argumento de no_use
                ))
            )) 
                l1) ; Pasa l1 como el valor inicial de x.
          l2)  ; Pasa l2 como el valor inicial de y.
    )
))

; Longitud.
(define longitud
  (lambda (l)
      ((Y (lambda (f)
         (lambda (x)
          (((vacia? x)
            (lambda (no_use)
              zero
            )
            (lambda (no_use)
              ((sumnat un) (f (cola x)))
            )
          )
            zero)  ; Pasa zero como argumento de no_use
        )
      ))
        l) ; Pasa l como el valor inicial de x.
    )
)

; Inversión.
(define invertir
    (lambda (l)
      ((Y (lambda (f)
             (lambda (x)
               (((vacia? x)
                 (lambda (no_use)
                   x
                 )
                 (lambda (no_use)
                   ((concatenar (f (cola x))) ((construir (cabeza x)) vacia))
                 )
              )
                zero)  ; Pasa zero como argumento de no_use
              )
          ))
            l) ; Pasa l como el valor inicial de x.
      )
)

; Test de pertenencia.
(define pertenece?
    (lambda (v)
        (lambda (l)
            (((Y (lambda (f)
                   (lambda (x)
                     (lambda (y)
                      (((vacia? y)
                       (lambda (no_use)
                            false
                        )
                       (lambda (no_use)
                            ((((esigualent x) (cabeza y))  
                             (lambda (no_use)
                                  true
                              ) 
                             (lambda (no_use)
                                  ((f x) (cola y))
                              )
                        
                           )
                              zero) ; Pasa zero como argumento de no_use
                       )
                    )
                        zero) ; Pasa zero como argumento de no_use
                ))
            )) 
                v)  ; Pasa v como el valor inicial de x.
          l)        ; Pasa l como el valor inicial de y.
    )
))

; Suma de los elementos de una lista.
(define sumar
    (lambda (l)
      ((Y (lambda (f)
             (lambda (x)
               (((vacia? x)
                 (lambda (no_use)
                   cero
                 )
                 (lambda (no_use)
                   ((sument (cabeza x)) (f (cola x)))
                 )
              )
                zero)  ; Pasa zero como argumento de no_use
              )
          ))
            l) ; Pasa l como el valor inicial de x.
      )
)

; Cálculo de máximo
(define maximo
    (lambda (l)
            ((Y (lambda (f)
                   (lambda (x)
                      (((vacia? (cola x))
                       (lambda (no_use)
                            (cabeza x)
                        )
                       (lambda (no_use)
                            ((((esmayorent (cabeza x)) (f (cola x)))  
                             (lambda (no_use)
                                  (cabeza x)
                              ) 
                             (lambda (no_use)
                                  (f (cola x))
                              )
                        
                           )
                              zero) ; Pasa zero como argumento de no_use
                       )
                    )
                        zero) ; Pasa zero como argumento de no_use
                ))
            )
          l)  ; Pasa l como el valor inicial de x.
    )
)

; Cálculo de mínimo.
(define minimo
    (lambda (l)
            ((Y (lambda (f)
                   (lambda (x)
                      (((vacia? (cola x))
                       (lambda (no_use)
                            (cabeza x)
                        )
                       (lambda (no_use)
                            ((((esmenorent (cabeza x)) (f (cola x)))  
                             (lambda (no_use)
                                  (cabeza x)
                              ) 
                             (lambda (no_use)
                                  (f (cola x))
                              )
                        
                           )
                              zero) ; Pasa zero como argumento de no_use
                       )
                    )
                        zero) ; Pasa zero como argumento de no_use
                ))
            )
          l)  ; Pasa l como el valor inicial de x.
    )
)

; Operación auxiliar de burbuja.
(define burbujaaux
    (lambda (l)
      ((Y (lambda (f)
             (lambda (x)
               (((vacia? (cola x))
                 (lambda (no_use)
                   x
                 )
                 (lambda (no_use)
                   ((((esmenorent (cabeza x)) (cabeza (cola x)))  
                    (lambda (no_use)
                         ((construir (cabeza x)) (f (cola x)))
                     ) 
                    (lambda (no_use)
                         ((construir (cabeza (cola x))) (f ((construir (cabeza x)) (cola (cola x)))))
                     )
                        
                   )
                      zero) ; Pasa zero como argumento de no_use
                 )
              )
                zero)  ; Pasa zero como argumento de no_use
              )
          ))
            l) ; Pasa l como el valor inicial de x.
      )
)

; Operación de la burbuja.
(define burbuja
    (lambda (l)
        (lambda (n)
            (((Y (lambda (f)
                   (lambda (x)
                     (lambda (y)
                      ((((esigualnat y) un)
                       (lambda (no_use)
                            (burbujaaux x)
                        )
                       (lambda (no_use)
                            ((f (burbujaaux x)) ((restanat y) un))
                        )
               
                    )
                        zero)  ; Pasa zero como argumento de no_use
                ))
            )) 
                l) ; Pasa l como el valor inicial de x.
          n)  ; Pasa n como el valor inicial de y.
    )
))

; Ordenación de una lista (usando burbuja).
(define ordenar
    (lambda (l)
      ((burbuja l) (longitud l))
    )
)

; Suma de listas consideradas como vector de un mismo tamaño.
(define sumar-listas
    (lambda (1l)
        (lambda (l2)
            (((Y (lambda (f)
                   (lambda (x)
                     (lambda (y)
                      (((vacia? x)
                       (lambda (no_use)
                            vacia
                        )
                       (lambda (no_use)
                         ((construir ((sument (cabeza x)) (cabeza y))) ((f (cola x)) (cola y)))
                        )
               
                    )
                        zero)  ; Pasa zero como argumento de no_use
                ))
            )) 
                1l) ; Pasa l1 como el valor inicial de x.
          l2)  ; Pasa l2 como el valor inicial de y.
    )
))


(define comprobar-lista (lambda (l)
             (if (= (comprobar (longitud l)) 0)
                          '()
                  (cons (testenteros (cabeza l)) (comprobar-lista (cola l))))))

(define vacia (lambda (x) x))

(define construir (lambda (x)
                    (lambda (y)
                      ((par false) ((par x) y)))))

(define lista-1 ((construir uno) vacia))

(define lista-2 ((construir dos) ((construir uno) vacia)))

(define lista-3 ((construir diecisiete) ((construir -doce) ((construir veinte) ((construir dos) ((construir -seis) vacia))))))

(define lista-4 ((construir siete) ((construir seis) ((construir doce) ((construir -diez) ((construir quince) ((construir nueve) vacia)))))))

(define lista-5 ((construir siete) ((construir cero) ((construir -doce) ((construir diez) ((construir quince) ((construir uno) vacia)))))))

(define vacia? (lambda (x) (primero x)))
(define cabeza (lambda (z) (primero (segundo z))))
(define cola (lambda (z) (segundo (segundo z))))