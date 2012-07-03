import Control.Applicative
import Data.Monoid
import Prime

sumIf f l r =
  let
    ms = (+) <$> l <*> r
  in
    case ms of
      Just s  -> if f s then
                   Just s
                 else
                   Nothing
      Nothing -> Nothing

-- sumUpTo max (x:xs) = x + sumUpTo max xs
