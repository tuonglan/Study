main = do
	line <- getLine
	if null line then
		return ()
	else do
		putStrLn $ reverseWords line
		main


reverseWords:: String -> String
reverseWords = foldl f []
	where f xs a = a:xs

myPutStr :: String -> IO ()
myPutStr [] = return ()
myPutStr (x:xs) = do
	putChar x
	myPutStr xs
