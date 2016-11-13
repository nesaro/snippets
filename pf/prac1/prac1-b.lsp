(first '(((a b) c) d)) 
(rest '(((a b) c) d)) 
(first (rest '(((a b) c) d))) 
(first (rest '((a b) ((c d) e)))) 
(first (first '(((a b) c) d)))
(rest '(first ((a b) c d))) 
(first (first (rest '((a b) (c d e))))) 
(rest (rest (rest '((a b) (c d) (e f))))) 

((la casa) de la pradera) 
(el tiene una (casa bonita)) 
((al anochecer) (se oye en la) (casa un piano)) 
((estuve ayer en) casa (de Pedro)) 
(((no importa que la) (casa sea muy vieja))) 
(((si no tienes una) casa) (la puedes alquilar)) 

(cons '(a b c) '()) 
(list '(a b c) '())  
(append '(a b c) '()) 
(cons '(ser o no ser ) '(esa es la cuestion)) 
(list '(ser o no ser) '(esa es la cuestion)) 
(append '(ser o no ser) '(esa es la cuestion)) 
(list (first nil) (rest nil)) 
(append (first nil) (rest nil)) 
(cons (first nil) (rest nil))

(setq frase (list 'el 'pianista 'toca 'bien)) 
(cons 'pepe frase) 
(length frase) 
frase 
(append '(en la calle) frase) 
(nconc frase '(la trompeta)) 
frase 

5. A partir de la siguiente lista "ejemplo", (setq ejemplo '((hamlet dinamarka) (woody allen septiembre) (tulipanes rojos) (romeo quiere mucho a julieta) (si por favor) (ensalada de tomate y lechuga)))) y utilizando las funciones estudiadas para el manejo de listas, construir las siguientes listas: 
(tulipanes dinamarka) 
((hamlet y woody) 
((romeo quiere) (tulipanes y lechuga))

