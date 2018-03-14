main = do
	putStrLn "Please enter three numbers"
	ls <- sequence . take 3 $ repeat getLine
	print ls


