
import Data.List (sort)
import Utils

sumDivs :: Integral a => a -> a
sumDivs = sum.properDivisors

isAmicableNumber :: Integral a => a -> Bool
isAmicableNumber a = ( sumDivs $ sumDivs a ) == a

amicableNumberPair :: Integral a => a -> Maybe ( a, a )
amicableNumberPair a | ( sumDivs sd ) == a = Just ( a , sd )
                     | otherwise           = Nothing
  where sd = sumDivs a

amicableNumbers :: Integral a => [a]
amicableNumbers = filter isAmicableNumber [1..]

-- amicablePairs :: Integral a => [(a, a)]
-- amicablePairs = foldl1 maybePair $ fmap amicableNumberPair [1..]
--   where
--     maybePair :: Integral a => Maybe ( a, a ) -> [(a, a)]
--     maybePair Just pair = [pair]
--     maybePair Nothing   = []

amicablePairs = fmap ( \ n -> ( n, sumDivs n ) ) amicableNumbers

uniquePairs [] = []
uniquePairs pairs = self ++ uniquePairs ( tail pairs )
  where
    self | (fst.head) pairs == (snd.head) pairs = []
         | otherwise = [(fst.head) pairs, (snd.head) pairs]

problem21 = show $ (sum.unique.sort.uniquePairs) as
  where
    as = takeWhile ( \ (a,b) -> a < 10000 ) amicablePairs

main = putStrLn problem21
