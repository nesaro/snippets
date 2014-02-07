data ItemMusical = Item String deriving Show
obtenerRuta :: ItemMusical -> String
obtenerRuta (Item x) = x


--data Coleccion = Col

main = do 
    putStr $ obtenerRuta (Item "AAA")
