module Monads

public export
while: Monad m => m Bool -> m () -> m ()
while c x = when !c (x >> while c x)

public export
until: Monad m => m Bool -> Lazy (m ()) -> m ()
until c x = while (not <$> c) x
