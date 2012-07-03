
module Prime where

import Data.List
import Utils

primes = testPrimes

sieveList n max = subSieveList 1
  where
    subSieveList i | n * i > max = []
                   | otherwise   = n * i : subSieveList ( i + 1 )

completeSieve [] = []
completeSieve a =
  let
    n = head a
    a' = ( tail a ) `sortedListDifference` ( multiplesOf n )
  in
    head a : completeSieve ( a' )

sievePrimes = completeSieve [2..]

-- newSieve :: Integral a => [a]
newSieve = 2 : unfoldr next [2]
  where
    next p = Just ( nextPrime p ,  p' )
      where p' = p ++ [ nextPrime p ]

-- given a list of contiguous primes, find the next prime
nextPrime ps = head $ filter ( not.(`isMultipleOfAny` ps) ) possibilities
  where
    possibilities = [ last ps + 1 .. last ps * 2 - 1 ]
    n `isMultipleOfAny` xs = any ( n `isMultipleOf` ) xs

isPrime 2 = True
isPrime n = not.or $ fmap (n `isMultipleOf`) [ 2 .. (ceiling.sqrt.fromIntegral) n ]

testPrimes = filter isPrime [2..]
