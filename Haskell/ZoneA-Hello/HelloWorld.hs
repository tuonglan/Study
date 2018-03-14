myReplicate :: Int -> a -> [a]
myReplicate 0 _ = []
myReplicate n a = a:(replicate (n-1) a)

myRepeat :: a -> [a]
myRepeat x = x:(myRepeat x)

myZip :: [a] -> [b] -> [(a,b)]
myZip [] _ = []
myZip _ [] = []
myZip (x:xs) (y:ys) = (x,y):(myZip xs ys) 

myElem :: (Eq a) => a -> [a] -> Bool
myElem _ [] = False
myElem a (x:xs)
	| a == x = True
	| otherwise = myElem a xs

qSort :: [a] -> [a]
qSort [] = []
qSort [a] = [a]
qSort x:xs = qSort([m | m <- xs, m <= x]) ++ [x] ++ qSort([n | n <- xs, n > x])
