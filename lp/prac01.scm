;Funcion expo: Se llama recursivamente con el exponente inferior:
;Devuelve falso con valores negativos

(define (expo numero exponente)
  (cond ((< exponente 0) #f)
		((= exponente 0) 1)
		(else (* numero (expo numero (- exponente 1))))))

;Inserta: sigo llamando recursivamente hasta que encuentro la posicion, generando la 
;lista adecuada con el cons

(define (inserta numero lista)
  (cond ((null? lista) '())
		((< (car lista) numero) (cons (car lista) (inserta numero (cdr lista))))
		(else (cons numero lista))))

;Scale: Multiplico por 10 cada elemento y sigo llamando a la funcion para el resto

(define (scale lista factor)
  (cond ((null? lista) '())
		(else (cons (* 10 (car lista))(scale (cdr lista) factor)))))

;Concatena, si la primera cadena no es nula sigo llamando, sino añado la segunda
;Inspirada en la misma función con el mismo nombre de los apuntes

(define (concatena lista1 lista2)
  (cond ((null? lista1) lista2)
		(else (cons (car lista1) (concatena (cdr lista1) lista2)))))

;Invierte: Me apoyo en concatena para ir añadiendo el primer elemento al final 
;y seguir llamando para el resto

(define (invierte lista)
  (cond ((null? lista) '())
		(else (concatena (invierte (cdr lista)) (list (car lista))))))

;Elimina: Si en cuentro una ocurrencia, llamo a la funcion para el resto,
;sino añado el primer elemento a la llamada del resto

(define (elimina elemento lista)
  (cond ((null? lista) '())
		((equal? (car lista) elemento) (elimina elemento (cdr lista)))
		(else (cons (car lista) (elimina elemento (cdr lista))))))

;Miembro?: Si encuentro el elemento devuelvo #t, si se me acaba la
;lista devuelvo #f, sino, sigo buscando en el resto de la lista

(define (miembro? elemento lista)
  (cond ((null? lista) #f)
		((equal? elemento (car lista)) #t)
		(else (miembro? elemento (cdr lista)))))

;repetidos: me apoyo en miembro y repetidos para eliminar las futuras ocurrencias 
; de cada elemento
(define (repetidos lista)
  (cond ((null? lista) '())
		((miembro? (car lista) (cdr lista)) (repetidos (cdr lista)))
		(else (cons (car lista) (repetidos (cdr lista))))))

;Ocurrencia: El let actua como un define que admite los argumentos 
;inicializados. Llamada pasa a ser una especie de funcion iterativa que guarda 
;en n el numero de ocurrencias. El motivo por el que lo he hecho así esta en 
;el comentario de la entrega de práctica

(define (ocurrencia elemento lista)
  (let llamada ((n 0) (milista lista))
  (cond ((null? milista) n)
		((equal? (car milista) elemento)(llamada (+ n 1)(cdr milista)))
		(else (llamada n (cdr milista))))))
  

;Extrae: va dejando pasar los elementos y restando uno a principio hasta que
;llega a 0. Despues resta 1 a final y sigue añadiendo a la rista resultante.
;Hasta que final se ha hecho 0 y ya no tiene nada más que añadir

(define (extrae lista principio final)
  (cond ((null? lista) '())
		((= final 0) '())
		((> principio 1)(extrae (cdr lista) (- principio 1) (- final 1)))
		(else (cons (car lista) (extrae (cdr lista) 0 (- final 1))))))


