import System.Environment
import Data.List

main = do
	args <- getArgs
	progName <- getProgName
	putStr "The arguments are: "
	mapM putStr $ map (\x -> x ++ " ") args
	putStrLn ""
	putStr "The program name is: "
	putStrLn progName
