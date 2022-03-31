module Primes
import Math
import Monads

export total
checkPrime: Integer -> Bool
checkPrime 2 = True
checkPrime 3 = True
checkPrime n = not$ any (\pf => n `mod` pf == 0 )
  $assert_total$ -- It's not obvious to Idris that using checkPrime with filter recursively is total.
  filter checkPrime [2..cast(sqrt(cast n))]

public export
Primes: Type
Primes = Stream Integer

export
brute: Primes
brute = brutePrimesFrom 3
  where
    brutePrimesFrom: Integer -> Primes
    brutePrimesFrom n = if checkPrime n
      then n :: brutePrimesFrom (n+2)
      else      brutePrimesFrom (n+2)

isSquare: Integer -> Bool
isSquare n = let nRoot2 = isqrt n in n == nRoot2*nRoot2

export
FermatFactor: Integer -> Integer
FermatFactor n = runST$ do
  a <- newSTRef (cast {to=Integer} (ceiling (isqrt n)))
  until (readSTRef a <&> \a => isSquare (a*a - n))
    (modifySTRef a (+1))
  readSTRef a <&> \a => a - isqrt(a*a - n)

