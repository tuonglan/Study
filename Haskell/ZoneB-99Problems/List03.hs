insertAt:: a -> [a] -> Int -> [a]
insertAt a xs 0 = a:xs
insertAt a (x:xs) i = x : insertAt a xs (i-1)


range':: Int -> Int -> [Int]
range' m n = [m..n]
