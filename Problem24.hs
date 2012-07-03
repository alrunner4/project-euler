
import Data.List

problem24 = show $ ( sort $ permutations [0..9] ) !! 999999

main = putStrLn problem24
