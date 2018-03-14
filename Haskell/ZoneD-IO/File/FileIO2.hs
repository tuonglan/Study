import System.IO
import Control.Exception

myWithFile :: FilePath -> IOMode -> (Handle -> IO a) -> IO a
myWithFile path mode f = bracket (openFile path mode) (\handle -> hClose handle) (\handle -> f handle)

main = do
	myWithFile "girlfriend.txt" ReadMode (\handle -> do
			contents <- hGetContents handle
			putStr contents)
