;Filtrar, función genérica vista en clase
(defun filtrar (funcion lista)
  (cond ((endp lista) nil)
		((funcall funcion (first lista))(cons (first lista) (filtrar funcion (rest lista))))
		(t (filtrar funcion (rest lista)))))

; valido devuelve si una posicion es valida
(defun valido  (mazmorra visitados elemento)
  (cond ((or (< (first elemento) 1)(< (second elemento) 1)(> (first elemento)(length mazmorra))(> (second elemento)(length mazmorra))) NIL)
		((not (nth (- (second elemento) 1) (nth (- (first elemento) 1) mazmorra))) NIL)
		((= 1 (bit visitados  (- (first elemento) 1)(- (second elemento) 1))) NIL)
		(T T)))

; vecinos devuelve una lista con los vecinos validos
(defun vecinos (mazmorra elemento visitados)
  (if (endp elemento) nil
  (let ((norte (list (+ (first elemento) 1)(second elemento)))
		(sur (list (- (first elemento) 1)(second elemento)))
		(este (list (first elemento)(- (second elemento) 1)))
		(oeste (list (first elemento)(+ (second elemento) 1))))
	(filtrar #'(lambda(x) (and (valido mazmorra visitados x)(setf (bit visitados (- (first x) 1)(- (second x) 1)) 1)))
			 (if (> (first elemento)(second elemento))(list oeste sur este norte)(list sur oeste norte este))))))

; distancia devuelve la distancia entre dos casillas 
(defun distancia (elemento1 elemento2)
  (let ((resta1 (if (> (first elemento1)(first elemento2))(- (first elemento1)(first elemento2))(- (first elemento2)(first elemento1))))
		(resta2 (if (> (second elemento1)(second elemento2))(- (second elemento1)(second elemento2))(- (second elemento2)(second elemento1)))))
	(sqrt (+ (* resta1 resta1) (* resta2 resta2)))))

;distanciafinal sirve como criterio de ordenación para el sort, permitiendo la busqueda en distancia.
(defun distanciafinal (elemento1 elemento2 referencia)
  (cond ((< (distancia elemento1 referencia)(distancia elemento2 referencia)) t)
		(t nil)))

;limpiar elimina aquellas casillas que no contribuyeron al camino final.
(defun limpiar (resultado)
 (cond ((endp resultado) nil)
	   ((= '1 (length resultado)) resultado)
	   ((= '1 (distancia (first resultado) (second resultado)))(cons (first resultado)(limpiar (rest resultado))))
	   (t (limpiar (cons (first resultado) (rest (rest resultado)))))))
	   

;busqueda saca el primer elemento de la lista s, inserta sus vecinos segun el criterio, y se llama a si misma de nuevo.
(defun busqueda (mazmorra visitados s resultado parametro)
  (if (endp s) nil
	(let* ((actual (first s))
			(vecin (vecinos mazmorra actual visitados)))
	   (cond ((equal actual (list (length mazmorra) (length mazmorra)))
			  (limpiar (append (list actual)resultado)))
			 ((equal parametro 'profundidad)
			  (busqueda mazmorra visitados (append vecin (rest s)) (append (list actual) resultado ) parametro))
			 ((equal parametro 'anchura)
			  (busqueda mazmorra visitados (append (rest s) vecin) (append (list  actual) resultado) parametro ))
			 ((equal parametro 'distancia)
			  (busqueda mazmorra visitados (sort (append vecin (rest s)) #'(lambda (x y) (distanciafinal x y (list (length mazmorra)(length mazmorra))))) (append (list actual) resultado) parametro))
			 (t nil)))))

;transformar convierte una pareja de casillas en una direccion.
(defun transformar (lista)
  (cond ((endp lista) NIL)
		((= '1 (length lista)) NIL)
		((< (first (first lista))(first (second lista)))(append '(abajo) (transformar (rest lista))))
		((< (second (first lista))(second (second lista)))(append '(derecha) (transformar (rest lista))))
		((> (first (first lista))(first (second lista)))(append '(arriba) (transformar (rest lista))))
		(t (append '(izquierda) (transformar (rest lista))))))

;compruebamazmorra devuelve verdadero solamente si todos los elementos son (t o nil)

(defun compruebamazmorra (lista)
  (cond ((endp lista) t)
		((listp (first lista)) (compruebamazmorra (append (first lista) (rest lista))))
		((member (first lista) '(nil t)) (compruebamazmorra (rest lista)))
		(t nil)))

;BuscaSalida es la funcion principal, hace una serie de comprobaciones previas con la entrada y despues crea una matriz para llamar a la función de busqueda

(defun BuscaSalida (mifichero 
					 &optional (tipobusqueda 'profundidad))
  (setf fichero (open mifichero))
  (setf mazmorra (read fichero))
  (close fichero)
  (cond ((and (listp mazmorra) (listp (first mazmorra)) (atom (first (first mazmorra))) (= (length mazmorra) (length (first mazmorra)))(compruebamazmorra mazmorra) (first (first mazmorra)))
		 (setf mvisita (make-array (list (length mazmorra) (length mazmorra)) :element-type 'bit :initial-element 0))
		 (setf (bit mvisita '0 '0) '1)
		 (transformar (reverse (busqueda mazmorra mvisita '((1 1)) '() tipobusqueda))))
		(t nil)))
