foldLeft :: (a -> a -> a) -> a -> [a] -> a
foldLeft f a [] = a
foldLeft f a (x:xs) = foldLeft f (f a x) xs

myMap :: (a -> b) -> [a] -> [b]
myMap f xs = foldr (\x acc -> f x : acc) [] xs

myMaximum :: (Ord a) => [a] -> a
myMaximum = foldl1 max

reverse' :: [a] -> [a]
reverse' = foldl (\acc x -> x : acc) []

and' :: [Bool] -> Bool
and' = foldr (&&) True

scanl' ::  (a -> b -> a) -> a -> [b] -> [a]
scanl' _ a [] = [a]
scanl' f a (x:xs) = a : scanl' f (f a x) xs

sqrtSums :: (Enum a, Floating a, Ord a) => a -> Int
sqrtSums a = length . takeWhile (<a) . scanl1 (+)  $ map sqrt [1..]

