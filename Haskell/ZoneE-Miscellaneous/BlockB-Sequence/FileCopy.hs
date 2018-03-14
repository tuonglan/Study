import System.Environment
import System.Directory
import System.IO
import Control.Exception
import qualified Data.ByteString.Lazy as B

main = do
	(fileName1:fileName2:_) <- getArgs
	myCopyFile fileName1 fileName2

myWithFile:: FilePath -> IOMode -> (Handle -> IO a) -> IO a
myWithFile path mode f =
	bracket (openFile path mode) (\handle -> hClose handle) (\handle -> f handle)

myCopyFile:: String -> String -> IO ()
myCopyFile source dest = do
	contents <- B.readFile source
	bracket 
		(openTempFile "." "temp")
		(\(tempName, tempHandle) -> do 
			hClose tempHandle
			renameFile tempName dest)
		(\(tempName, tempHandle) -> do 
			B.hPutStr tempHandle contents)
