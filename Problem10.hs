
import Prime

-- Calculate the sum of all primes below two million --
problem10 = show $ sum $ takeWhile ( < 2000000 ) primes

main = putStrLn $ "Problem10: " ++ problem10
