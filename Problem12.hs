
import Utils

triangle n = sum [1..n]

triangles = scanl1 (+) [1..]

problem12 = case firstOf ( \n -> ( length $ divisors n ) > 500 ) triangles of
  Nothing -> ""
  Just n -> show n

problem12debug highest (tri:remaining) = do
  if highest > 500 then return () else do
    let numDivs = length $ divisors tri
    if numDivs > highest then putStrLn ( show tri ++ " has " ++ show numDivs ++ " divisors" ) else return ()
    problem12debug ( max numDivs highest ) remaining

-- main = problem12debug 0 triangles
main = putStrLn problem12
