-- Tossing a coing --
import System.Random

threeCoins :: StdGen -> (Bool, Bool, Bool)
threeCoins gen = (firstCoin, secondCoin, thirdCoin)
	where
		(firstCoin, newGen) = random gen
		(secondCoin, newGen') = random newGen
		(thirdCoin, newGen'') = random newGen'

	
randoms' :: (RandomGen g, Random a) => g -> [a]
randoms' g = a : randoms' g'
	where (a, g') = random g
