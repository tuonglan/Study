import Control.Monad
main = do
	line <- getLine
	when (line == "Swordfish") $ do
		putStrLn line
	rs <- sequence [getLine, getLine, getLine]
	print rs
