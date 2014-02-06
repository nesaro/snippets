info :: String -> String
info a = "+" ++ a


main = do putStr "Add a number\n>"
          my_data <- getLine
          xs <- readFile "data.txt"
          putStr "Last number was:\n"
          putStr (info (last (lines xs)))
          putStr "\n"
          putStr "difference is:\n"
          putStr $ show $ read my_data - read ( last (lines xs))
          writeFile "data.txt" my_data
          putStr "\n"
          
    
