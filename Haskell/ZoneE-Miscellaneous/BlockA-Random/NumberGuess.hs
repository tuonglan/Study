import System.Random
import Control.Monad(when)

main = do
	gen <- getStdGen
	askForNumber gen

askForNumber :: StdGen -> IO ()
askForNumber gen = do
	putStrLn "Please guess about a number in range (1, 10): "
	numberStr <- getLine
	when (not $ null numberStr) $ do
		let (randNumber, newGen) = randomR (1,10) gen :: (Int, StdGen)
		if randNumber == read numberStr then
			putStrLn "Wao, you're genious"
		else
			putStrLn $ "Your're wrong, the right number is: " ++ show randNumber
		askForNumber newGen
