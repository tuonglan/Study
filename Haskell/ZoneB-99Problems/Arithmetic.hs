isUnDivisible:: Int -> [Int] -> Bool
isUnDivisible n [x] = mod n x /= 0
isUnDivisible n (x:xs) = (mod n x /= 0) && (isUnDivisible n xs)

isPrime:: Int -> Bool
isPrime n = isUnDivisible n $ take (round $ sqrt $ fromIntegral n) [2..]

myAll:: (a -> Bool) -> [a] -> Bool
myAll f [x] = f x
myAll f (x:xs) = (f x) && (myAll f xs)

gcd':: Int -> Int -> Int
gcd' 0 n = n
gcd' n 0 = n
gcd' m n
	| m > n = gcd' (m - n) n
	| m < n = gcd' m (n - m)
	| m == n = m

isCoprime m n = (gcd' m n) == 1
