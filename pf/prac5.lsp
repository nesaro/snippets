;;Néstor Arocha Rodríguez - Práctica de programación funcional
;;Práctica 5
;;------------------------------------------------------------

;listamenor devuelve las listas de lista con menos de n elementos
(defun listamenor (n lista)
  (cond ((endp lista) NIL)
		((< (length (first lista)) n)(cons (first lista)(listamenor n (rest lista))))
		(T (listamenor n (rest lista)))))

;cuenta-letras se apoya en cuantasletras para devolver el numero de letras de cada termino de la lista que coinciden con palabra
(defun cuantasletras (referencia palabra)
  (let ((suma '0))
  (dolist (x referencia suma)(if (member x palabra)(setq suma (+ suma '1))))))

(defun cuenta-letras (palabra lista)
  (cond ((endp lista) NIL)
		(T (cons (cuantasletras palabra (first lista)) (cuenta-letras palabra (rest lista))))))

;Comofindif emula el funcionamiento de findif
(defun comofindif (funcion lista)
  (cond ((endp lista) NIL)
		((funcall funcion (first lista))(first lista))
		(T (comofindif funcion (rest lista)))))

;aplica la funcion funcion a aquellos elemento de la lista que pasen el selector
(defun filtra2 (funcion selector lista)
  (cond ((endp lista) NIL)
		((funcall selector (first lista))(cons (funcall funcion (first lista))(filtra2 funcion selector (rest lista))))
		(T (filtra2 funcion selector (rest lista)))))

