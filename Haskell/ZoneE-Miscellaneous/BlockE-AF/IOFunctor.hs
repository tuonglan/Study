import Control.Applicative

main = do
	str <- (++) <$> ((++" ") <$> getLine) <*> getLine
	putStrLn $ "The actually string turns out to be: " ++ str
