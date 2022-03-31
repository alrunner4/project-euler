import Lists {- first, last -}
import Math {- isqrt -}

export total
factors: Integer -> List Integer
factors n = case first (\ i => n `mod` i == 0) [2 .. isqrt n] of
  Just i => i :: factors (assert_smaller n (n `div` i))
  Nothing => [n]

||| The prime factors of 13195 are 5, 7, 13 and 29.
||| What is the largest prime factor of the number 600851475143 ?
main: IO ()
main = let
  sample = 13195
  magic = 600851475143
  in printLn (last (factors magic))
