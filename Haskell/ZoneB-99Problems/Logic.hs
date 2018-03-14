-- Problem 46
and':: Bool -> Bool -> Bool
and' a b = a && b

table:: (Bool -> Bool -> Bool) -> IO ()
table f =
	mapM_ print $ map p boolList
		where
			p (a,b) = (show a) ++ " " ++ (show b) ++ " " ++ (show $ f a b)
			boolList =  [(a,b) | a <- [True, False], b <- [True, False]]


-- Problem 48
logicTable::(Num n) => n -> IO ()

