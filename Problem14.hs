
import qualified Data.Map as Map

-- next :: Integer -> Integer
next n
  | even n = n `div` 2
  | odd  n = 3 * n + 1

problemSequence :: Integer -> [Integer]
problemSequence n
  | n == 1    = [n]
  | otherwise = problemSequence ( next n )

shortSequence _   1     = []
shortSequence max start = buildSequence ( next start )
  where
    buildSequence n
      | n < max   = [n]
      | otherwise = n : buildSequence ( next n )

-- problemTable :: Integer -> [ [ Integer ] ]
problemTable m = fmap ( shortSequence m ) [ 1 .. m ]

entryLength :: [ [ Integer ] ] -> Int -> Int    
entryLength table n
  | row == [] = 0
  -- | last row == 1 = length ( table !! n )
  | otherwise = length ( row ) + entryLength table ( fromInteger $ last row )
    where
      row :: [ Integer ]
      row = table !! ( n - 1 )

sequenceLengths m = fmap ( entryLength ( problemTable m ) ) [1..mInt]
  where
    mInt :: Int
    mInt = fromInteger m

-- problemTable :: Integer -> [ [ Integer ] ]
-- problemTable 1 = []
-- problemTable m = pt m
--   where
--     pt n = pt ( n - 1 ) ++ [ shortSequence m n ]

-- quickProblem :: Integer -> [ [ Integer ] ]
-- quickProblemSequences m = 
--   where
