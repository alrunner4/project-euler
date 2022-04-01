import Lists

isPalindrome: Show a => a -> Bool
isPalindrome x = let s = show x in s == reverse s

||| A palindromic number reads the same both ways. The largest palindrome made from the product of
||| two 2-digit numbers is 9009 = 91 × 99.
||| Find the largest palindrome made from the product of two 3-digit numbers.
main: IO ()
main = printLn$ foldl max 0
  [ (1000-x)*(1000-y) | x <- [1..999], y <- [1..x], isPalindrome ((1000-x)*(1000-y)) ]

