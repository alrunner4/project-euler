module Monads

public export
while: Monad m => m Bool -> m () -> m ()
while c x = if !c then x >> while c x else pure ()

public export
until: Monad m => m Bool -> m () -> m ()
until c x = if !c then pure () else x >> until c x
