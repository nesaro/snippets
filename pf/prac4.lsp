;;Néstor Arocha Rodríguez - Práctica de programación funcional
;;Práctica 4
;;------------------------------------------------------------

;rota la lista a la izquierda o derecha nelem veces
;No entiendo por que son necesarios argumentos &key
(defun rotar (lista &optional (direccion 'izquierda) (nelem 1) )
  (cond ((equal direccion 'izquierda )(dotimes (variable nelem lista)(setq lista (append (rest lista) (list (first lista))))))
  ((equal direccion 'derecha )(dotimes (variable nelem lista)(setq lista (append (last lista)(butlast lista)))))
  ((T NIL))))
  
	
;palindromp-rec detecta si lista es un palindromo
;Al ser recursiva, tiene dos casos base. (contempla lista de tamaño par e impar)
(defun palindromp-rec (lista)
  (cond ((endp lista) T)
		((= (LENGTH lista) 1) T)
		((EQL (first lista) (FIRST(last lista))) (palindromp-rec (rest (butlast lista))))
		(T NIL)))


;Mi maximo, devuelve el mayor elemento de una lista
; Si solo queda un elemento y este es una lista (porque la lista inicial era una lista de listas)
; devuelve mi-maximo de ese elemento
; Si solo queda ese elemento, lo devolvemos
; Si el primero es una lista, llamamos a la funcion para esa lista
;Idem para el segundo
;Si los dos son atomos, los comparamos y llamamos a la funcion recursuvamente 
;con todos los elementos menos con el menor
(defun mi-maximo (lista)
  (cond ((and (= (length lista) 1)(listp (first lista)))(mi-maximo (first lista)))
		((= (length lista) 1) (first lista)) 
		((listp (first lista)) (mi-maximo (cons (mi-maximo (first lista)) (rest lista))))
		((listp (second lista)) (mi-maximo (cons (first lista) (cons (mi-maximo (second lista)) (rest (rest lista))))))
		(T (if (> (first lista) (second lista)) (mi-maximo (cons (first lista) (rest (rest lista)))) (mi-maximo (rest lista))))))

;Mi-maximo-term se apoya en mi-maximo-temp . 
;mi-maximo-temp se llama a si misma comparando el primer elemento con el maximo dado y asignando el nuevo maximo
(defun mi-maximo-temp (lista maximo)
  (cond ((endp lista) maximo)
		((listp (first lista)) (max (mi-maximo-temp (first lista) maximo) (mi-maximo-temp (rest lista) maximo )))
		(T (if (> (first lista) maximo) (mi-maximo-temp (rest lista) (first lista)) (mi-maximo-temp (rest lista) maximo)))))

(defun mi-maximo-term (lista)
  (mi-maximo-temp lista 0))

