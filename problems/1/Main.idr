||| If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9.
||| The sum of these multiples is 23.  Find the sum of all the multiples of 3 or 5 below 1000.
main: IO ()
main = printLn
  (concatMap @{(%search, Additive)} (\x =>
    if x `mod` 3 == 0 || x `mod` 5 == 0
      then x
      else the Integer 0)
    [1..999])
