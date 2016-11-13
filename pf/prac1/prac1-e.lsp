(setq ejemplo '((hamlet dinamarka) (woody allen septiembre) (rulipanes rojos) (romeo quiere mucho a julieta) (si por favor) (ensalada de tomate y lechuga)))
(print(list (first(first(rest(rest ejemplo))))(first(rest(first ejemplo)))))
(print(list (list(first(first ejemplo))(first(rest(rest(rest(first(last ejemplo))))))(first(first(rest ejemplo )))) (first(last(first(rest(rest(rest ejemplo))))))  ))
(print(list(list(first(nth 3 ejemplo))(first(rest(nth 3 ejemplo))) (list (first(nth 2 ejemplo)) (nth 3 (first(last ejemplo))) (first(last(first(last ejemplo)))) ) )))
