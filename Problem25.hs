
import Utils

problem25 = show $ (+1) $ length $ takeWhile ( < 10^999 ) fibonacci

main = putStrLn problem25
