
--Ejercicio 2.28
--
infix 4 |>
(|>) :: [ x -> y ] -> x -> [ y ]
(|>) (x:xs) j = x j : (|>) xs j
(|>) [] j = []

--main = putStr [(+) 1,(+) 2] |> 4
--
--[1 of 1] Compiling Main             ( 2-28.hs, interpreted )
--Ok, modules loaded: Main.
-- *Main> [(+) 1, (+2) ] |> 4
-- [5,6]
--

--Ejercicio 2.29

esBisiesto :: Integer -> Bool
esBisiesto x 
         |  x `mod` 400 == 0 = True
         |  x `mod` 100 == 0 = False
         |  x `mod` 4 == 0 = True
         |  True = False
--Ejercicio 2.30 

diasDelMes :: Integer -> Integer -> Integer
diasDelMes x y = case x of
        1 -> 31
        2 -> if esBisiesto y then 29 else 28
        3 -> 31
        4 -> 30
        5 -> 31
        6 -> 30
        7 -> 31
        8 -> 31
        9 -> 30
        10 -> 31
        11 -> 30 
        12 -> 31


--Ejercicio 2.31. `` <- convierte una funcion en operador

aLaDerechaDe :: Integer -> Integer -> Integer
aLaDerechaDe x y = x + 10 * y

--Ejercicio 2.32. 

restoRecursivo :: Integer -> Integer -> Integer
restoRecursivo a b 
        | a < b = a
        | a == b = 0
        | True = restoRecursivo (a-b) b


-- 2.33

cocienteRecursivo:: Integer -> Integer -> Integer
cocienteRecursivo a b
        | a >= b = 1 + cocienteRecursivo (a-b) b
        | True = 0


-- 2.34

sumDesteHasta :: Integer -> Integer -> Integer
sumDesteHasta a b 
        | a <= b = a + sumDesteHasta (a+1) b
        | True = 0

-- 2.35

prodDesteHasta :: Integer -> Integer -> Integer
prodDesteHasta a b 
        | a <= b = a * prodDesteHasta (a+1) b
        | True = 1

-- 2.36

factorial :: Integer -> Integer
factorial 0 = 1
factorial (n+1) = (n+1) * factorial n

variaciones :: Integer -> Integer -> Integer
variaciones m n = factorial m `div` factorial (m - n)

variaciones2 :: Integer -> Integer -> Integer
variaciones2 m n
            | n == 0 = 1
            | True = (m - n + 1) * (variaciones2 m (n-1))
-- 2.37

combinatorios :: Integer -> Integer -> Integer
combinatorios m n = variaciones m n `div` factorial n

combinatorios2 :: Integer -> Integer -> Integer
combinatorios2 _ 0 = 1
combinatorios2 m n 
            | m == n = 1
            | True = (combinatorios2 (m-1) (n-1)) + (combinatorios2 (m-1) (n))

-- Si n es mayor que m no acaba porque el segundo termino de combinatorios2 nunca llega a una condicion base

--2.38
fibonacci :: Integer -> Integer
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n-1) + fibonacci (n-2)

--2.39
mayorde3 :: Integer -> Integer -> Integer -> Integer
mayorde3 x y z
        | (x > y) && (x > z) = x
        | y > z = y
        | True = z

mayorde4 :: Integer -> Integer -> Integer -> Integer -> Integer
mayorde4 j x y z
        | mayorde3 x y z > j = mayorde3 x y z
        | True = j

--2.40
--
ordena3 :: Integer -> Integer -> Integer -> (Integer, Integer, Integer)
ordena3 a b c 
        | (a > b) && (b > c) = (a, b, c)
        | (a > b) && (a > c) = (a, c, b)
        | (b > c) && (a > c) = (b, a, c)
        | (b > c) = (b, c, a)
        | (a > b) = (c, a, b)
        | True = (c, b, a)

esCapicua :: Integer -> Bool
esCapicua a
        | a < 1000 = error "Muy pequeño"
        | a > 10000 = error "Muy grande"
        | (a `div` 1000) /= (a `mod` 10) = False
        | ((a `div` 100) `mod` 10) /= ((a `mod` 100) `div` 10) = False
        | otherwise = True

--2.42
--
sumaCifras :: Integer -> Integer
sumaCifras x
        | x < 10 = 1
        | otherwise = (x `mod` 10) + sumaCifras (x `div` 10)
