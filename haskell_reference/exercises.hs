-- 1
myLast :: [x] -> x
myLast [x] = x
myLast (_:resto) = myLast resto

--2

myButLast :: [x] -> x
myButLast [x,_] = x
myButLast (_,resto) = myButLast resto

main = do
       putStr "Problema 1"
       putStr $ myLast ["b","a"]
       putStr "\n"
       putStr "FIN\n"
