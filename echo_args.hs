import System.Environment


main = getArgs >>= putStr.unlines
--main = do
--    lista <- getArgs
--    putStr  lista

