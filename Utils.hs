
module Utils where

import Data.Monoid ( First ( First ) , mconcat )

multiplesOf n = fmap (*n) [1..]

isMultipleOf x y = ( x `mod` y ) == 0

properDivisors n = filter ( n `isMultipleOf` ) [ 1 .. n `div` 2 ]
-- divisors n = properDivisors n ++ [n]

coDivisor n d = if n `isMultipleOf` d then Just ( d , n `div` d ) else Nothing
fastDivisors n ( min , max ) = let
  coDivs = map ( coDivisor n ) [ min .. max ]
  firstDivisor = mconcat $ map First coDivs
  in case firstDivisor of
    First Nothing -> []
    First ( Just ( minDiv , maxDiv ) ) -> if minDiv == maxDiv then [minDiv] else minDiv : fastDivisors n ( minDiv + 1 , maxDiv - 1 ) ++ [maxDiv]

divisors 1 = [1]
divisors 2 = [1,2]
divisors n = 1 : fastDivisors n ( 2 , (ceiling.sqrt.fromIntegral) n ) ++ [n]

sortedListDifference [] _ = []
sortedListDifference a [] = a
sortedListDifference (a:as) (b:bs) | a == b = sortedListDifference as (b:bs)
                                   | a < b  = a : sortedListDifference as (b:bs)
                                   | a > b  = sortedListDifference (a:as) bs

unique [] = []
unique [a] = [a]
unique (a:b:x) | a == b = a : unique x
               | otherwise = a : unique ( b : x )

sumDigits 0 = 0
sumDigits n | n < 0 = sumDigits ( abs n )
sumDigits n = n `mod` 10 + sumDigits ( n `div` 10 )

numDigits 0 = 0
numDigits n | n < 0 = numDigits ( abs n )
numDigits n = 1 + numDigits ( n `div` 10 )

factorial 0 = 1
factorial n | n < 0 = error "factorial: not valid on negative numbers"
factorial n = n * factorial ( n - 1 )

repeatedApplication n start f = foldl ( \ a f -> f a ) start ( take n $ repeat f )

repeatedApp f i = scanl ( \ a f -> f a ) i ( repeat f )

multiFmap fs xs = fmap ( \ ( f , n ) -> f n ) ( zip fs xs )

class Sequence s where
  after :: s -> s
  advanceSequence :: ( Integral n ) => s -> n -> s
  advanceSequence start n = repeatedApplication ( fromIntegral n ) start after

class RSequence a where
  before :: a -> a

fibonacciN 1 = 1
fibonacciN 2 = 1
fibonacciN n = fibonacciN ( n - 2 ) + fibonacciN ( n - 1 )

-- fibonacci = fmap snd $ repeatedApp fibber (0,1)
--   where
--     fibber ( l , r ) = ( r , l + r )

fibonacci = 1 : 1 : zipWith (+) fibonacci ( tail fibonacci )

firstOf _ [] = Nothing
firstOf p (x:xs) = if p x then Just x else firstOf p xs
