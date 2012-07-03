
module Problem29 where

import Utils

firsts = fmap (,) [1..]

allPairs :: [ a ] -> [ b ] -> [ ( a , b ) ]
allPairs as bs = multiFmap firsts bs
  where
    firsts = fmap (,) as
