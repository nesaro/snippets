(print(listp (first '((programacion) funcional))))
(print(atom (first '(1 2))) )
(print(endp (rest '(james bond))) )
(print(null nil) )
(print(listp (rest (first '((a) b)))) )
(print(symbolp (rest (rest '(a b)))) )
(print(consp (rest (last '(rojo verde azul)))) )
(print(numberp (rest '(a 1))) )
(print(symbolp (first '(29 132))) )
(print(consp (rest '(loro mono caiman))) )
(print(null t) )
(print(consp (cons nil nil)) )
(print(endp (rest (first '((a) b)))) )
(print(atom (rest '(48 23.4))) )
(print '(separador))
(print(eq 'gato (first (rest '(bonito gato))))          )
(print(= 5.0 10/2)                                      )
(print(eq '(el hombre) (first '((el hombre) cromagnon)))) 
(print(equal 8 (* 2 4.0))                               )
(print(= 3 (* 2 1.5))                                   )
(print(equal '(a b) (first (first '(((a b)) c))))       )
(print(eql 2 2.0)                                       )
(print(equal '(pato donald) (cons 'pato '(donald)))     )
(print(equal 'c (rest (rest '(a b c))))                 )
(print(equal 3 (/ 9 3))                                 )
(print(equal 'c (first (rest (rest '(a b c)))))         )
(print(eql 2 (/ 10 5))                                  )
(print(equal '(mickey mouse) (list 'mickey 'mouse))     )
(print(eq 'pato 'pato)                                  )
(print(eq (second '(a b)) (second (first '((a b) c))))  )
(print '(separador))
(print(setq lista '(es muy divertido programar en lisp)) )
(print(and lista) )
(print(or lista) )
(print(and (first lista) (last lista)) )
(print(or (equal (first lista) 'es) (equal (second lista) 'no)) )
(print(or (endp (rest lista)) (first lista) 'lisp) )
(print(and (numberp (first lista)) (symbolp (last lista))) )
(print(and (= (length lista) 6) (= (- (length lista) 1) 5)) )
(print(setq valor (or (numberp (first lista)) (atom (rest lista)))) )
(print(and (not valor) valor))
(print(<(length lista) 9))
