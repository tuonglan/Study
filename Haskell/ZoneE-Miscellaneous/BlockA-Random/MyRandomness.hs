import System.Random

infiniteRandom :: (RandomGen g, Random a) => g -> [a]
infiniteRandom g = a : infiniteRandom g'
	where (a, g') = random g

main = do
	putStrLn "Hello, what's your name?"
	name <- getLine
	putStrLn $ "Hey " ++ name ++ " you rock"
