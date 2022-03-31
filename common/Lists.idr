module Lists

public export total
first: (a -> Bool) -> List a -> Maybe a
first _ [] = Nothing
first p (x :: xs) = if p x then Just x else first p xs

public export
last: List a -> Maybe a
last [] = Nothing
last [x] = Just x
last (x::xs) = last xs

namespace Stream
  public export
  first: (a -> Bool) -> Stream a -> a
  first p (x :: xs) = if p x then x else first p xs


