
;;Néstor Arocha Rodríguez - Práctica de programación funcional
;;Práctica 6
;;------------------------------------------------------------

;Estructura libro
(defstruct libro titulo autor editorial ano)


;convierte-estruct pasa los elementos de las listas a estructuras
(defun convierte-estruct (ltitulos lautores leditorial lano)
  (cond ((endp ltitulos) NIL)
		(T (cons (make-libro :titulo (first ltitulos) :autor (first lautores) :editorial (first leditorial) :ano (first lano)) (convierte-estruct (rest ltitulos)(rest lautores)(rest leditorial )(rest lano))))))

;est2par transforma una estructura en una lista de pares punteados
(defun est2par (milibro)
  (cons (libro-titulo milibro) (list (libro-autor milibro) (libro-editorial milibro) (libro-ano milibro))))

;Guardo en una lista las sucesivas llamadas a est2par
(defun crea-tabla (lista)
  (cond ((endp lista) NIL)
		(T (cons (est2par (first lista)) (crea-tabla (rest lista))))))

;producto escalar de dos vectores
(defun multi-vectores (vec1 vec2)
  (cond ((endp vec1) '0)
		(T (+ (* (first vec1)(first vec2)) (multi-vectores (rest vec1)(rest vec2))))))

;devuelve el numero de filas
(defun nfil (matriz)
  (first (array-dimensions matriz)))

;devuelve el numero de columnas
(defun ncols (matriz)
  (second (array-dimensions matriz)))

;devuelve un vector con la columna
(defun columna (matriz numero)
  (let ((lista '()))
	(dotimes (iter (nfil matriz) lista)
	  (setf lista (append lista (list (aref matriz iter numero)))))))
 
;devuelve un vector con la fila
(defun fila (matriz numero)
  (let ((lista NIL))
	(dotimes (iter (ncols matriz) lista)
	  (setf lista (append lista (list (aref matriz numero iter)))))))

;cada elemento de la matriz final es el producto de la fila i de la primera por la columna j de la segunda
(defun multi-matrices (mat1 mat2)
  (setq pepe (make-array (list (nfil mat1)(ncols mat2))))
  (dotimes (i (ncols mat1) NIL) 
	(dotimes (j (nfil mat2) NIL)
	  (setf (aref pepe i j) (multi-vectores (fila mat1 i)(columna mat2 j))))) 
  pepe)


(print (crea-tabla (convierte-estruct '(lisp latex) '(winston kopka) '(addison-wes prentice-hall) '(1997 19959))))
(setq ide (make-array '(3 3) :initial-element 0))
(setq jojo (make-array '(3 3) :initial-element 2))
(setf (aref ide 0 0) 1)
(setf (aref ide 1 1) 1)
(setf (aref ide 2 2) 1)
(trace multi-matrices)
;(trace multi-vectores)
;(trace columna)
;(trace nfil)
;(multi-matrices jojo ide)


