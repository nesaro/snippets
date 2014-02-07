;; Néstor Arocha Rodríguez - Práctica de programación funcional
;; Práctica 3
;; ------------------------------------------------------------

;; Funcion palindromp, detecta si lista es un palindromo
(defun palindromp (lista)
  (equal lista (reverse lista)))

;;Mezclar, Mezcla lista1 (hasta n) con lista 2 (desde n+1)
;;No estoy seguro de si esta funcion esta hecha de la forma "lispera"
(defun mezclar (lista1 lista2 n)
  (append (butlast lista1 (- (length lista1) n)) (nthcdr n lista2 )))

;; Esta en lista devuelve verdader si el elemento pertenece a la lista
(defun esta-en-lista (elemento lista)
  (if (endp lista) NIL (or  (eq (first lista) elemento)(esta-en-lista elemento (rest lista)))))


;;Funcion borrador, devuelve una lista sin el elemento elemenento
;Simplemente recorro la lista añadiendo a resultado aquellos elementos que son diferentes al pedido
;A la lista resultado

(defun borrador (elemento lista)
  (setq resultado '())
  (dolist (elem (reverse lista) resultado)
	(if (not (equal elem elemento)) (setq resultado(cons elem resultado)))))
	

