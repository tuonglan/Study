import System.IO
import System.Directory
import Data.List

main = do
	contents <- readFile "todo.txt"
	let
		todoTasks = lines contents
		numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [1..] todoTasks
	putStrLn "These are the list of TODO things: "
	mapM_ putStrLn numberedTasks
	putStrLn "Which task did you finish"
	taskString <- getLine
	let 
		taskNumber = read taskString
		newTodoTasks = unlines $ delete (todoTasks !! (taskNumber - 1)) todoTasks
	(tempName, tempHandle) <- openTempFile "." "temp"
	hPutStr tempHandle newTodoTasks
	hClose tempHandle
	renameFile tempName "todo-new.txt"
	withFile tempName ReadMode (\handle -> do
		contents <- hGetContents handle
		putStr contents
		)
