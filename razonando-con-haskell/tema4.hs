--4.25

--4.26
--type Complejo = (Char,Float,Float)
--infixl 9 >+<
--(>+<) :: Complejo -> Complejo -> Complejo
--(>*<) :: Complejo -> Complejo -> Complejo
--
--polarACartesiano :: Complejo -> Complejo 
--cartesianoAPolar :: Complejo -> Complejo 
--
--polarACartesiano ('c',x,y) = ('c',x,y)
--polarACartesiano ('p',x,y) = ('c',x*cos(y),x*sin(y))
--
--cartesianoAPolar ('p',x,y) = ('p',x,y)
--cartesianoAPolar ('c',x,y) = ('p',sqrt(x**2 + y ** 2),atan2 x y)
--
--('c',b,c) >+< ('c',f,g) = ('c',b+f,c+g)
--('p',b,c) >+< ('c',f,g) = polarACartesiano ('p',b,c) >+< ('c',f,g)
--('c',b,c) >+< ('p',f,g) = polarACartesiano ('p',f,g) >+< ('c',b,c)
--
--('p',b,c) >*< ('p',f,g) = ('p',b*f,c+g)
--('c',b,c) >*< ('p',f,g) = cartesianoAPolar ('c',b,c) >+< ('p',f,g)
--('p',b,c) >*< ('c',f,g) = cartesianoAPolar ('c',f,g) >+< ('p',b,c)
--
--4.27

data Complejo2 = Carte Float Float | Polar Float Float deriving Show
infixl 9 >+<

(>+<) :: Complejo2 -> Complejo2 -> Complejo2
(>*<) :: Complejo2 -> Complejo2 -> Complejo2

Carte a b >+< Carte c d = Carte (a+c) (b+d)
Polar a b >*< Polar c d = Polar (a*c) (b+d)

