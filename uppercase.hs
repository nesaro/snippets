import System.IO
import Data.Char
brains :: String -> String
-- whatever you want the brains to be
brains s = map Data.Char.toUpper s

main = interact brains
