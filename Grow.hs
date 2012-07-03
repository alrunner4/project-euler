module Grow where

grow :: [a] -> ( [a] -> a ) -> [a]
grow i f = i' ++ grow i' f
  where
    i' = i ++ [ f i ]
--       = mappend i ( f i )
