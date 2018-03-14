isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome [] = True
isPalindrome xs  = foldl1 (&&) . zipWith (\x y -> x == y) xs $ reverse xs

data NestedList a = Elem a | List [NestedList a]
-- <<<<<<< HEAD
flattenList :: NestedList a -> [a]
flattenList (Elem a) = [a]
flattenList (List (x:xs)) = flattenList x ++ flattenList (List xs)
flattenList (List []) = []

-- Flatten list with foldr 
flattenList' :: NestedList a -> [a]
flattenList' (Elem a) = [a]
flattenList' (List xs) = foldr (++) [] $ map flattenList' xs

-- Problem 8
compressList :: (Eq a) => [a] -> [a]
compressList [] = []
compressList [a] = [a]
compressList (x:y:xs)
	| x == y = compressList (x:xs)
	| otherwise = x : compressList (y:xs)

compressList' :: (Eq a) => [a] -> [a]
compressList' = foldr f []
	where 
		f x [] = [x]
		f x (y:ys)
			| x == y = (y:ys)
			| otherwise = (x:y:ys)
-- =======
myFlatten:: NestedList a -> [a]
myFlatten (Elem a) = [a]
myFlatten (List []) = []
myFlatten (List xs) = foldr (++) [] $ map myFlatten xs

myPack:: (Eq a) => [a] -> [[a]]
myPack = foldr f []
	where 
		f a [] = [[a]]
		f a ((x:xs):xxs) = if (a == x) then ((a:x:xs):xxs) else ([a]:(x:xs):xxs)

encode':: (Eq a) => [a] -> [(Int, a)]
encode' = map (\s -> (length s, head s)) . myPack
-- >>>>>>> 5b5f2ab1f6ac1b8499bf7034b7aab72ff8cdf4d1

dupli:: [a] -> [a]
dupli = foldr (\x y -> x:x:y) []

repli:: Int -> [a] -> [a]
repli n = foldr f []
	where f a xs = (take n $ repeat a) ++ xs

split:: (Enum a) => [a] -> Int -> Int -> [a]
split xs m n = [(xs !! (m-1)) .. (xs !! (n-1))]

removeAt :: Int -> [a] -> (a, [a])
removeAt n xs = ((xs !! (n-1)), [x | (x, i) <- zip xs [1..], i /= n])

removeAt' :: Int -> [a] -> (a, [a])
removeAt' 0 (x:xs) = (x, xs)
removeAt' n (x:xs) = (l, x:ys)
	where (l, ys) = removeAt' (n-1) xs

slice :: [a] -> Int -> Int -> [a]
slice xs m n = [x | (x,i) <- zip xs [1..], i >= m, i <=n]

insertAt :: a -> [a] -> Int -> [a]
insertAt a xs 0 = a:xs
insertAt a (x:xs) n = x:ys
	where ys = insertAt a xs (n-1)

range :: Int -> Int -> [Int]
range m n
	| m == n = [n]
	| m < n = m : (range (m+1) n)
	| m > n = m : (range (m-1) n)
