import Data.List

data Section = Section {getA :: Int, getB :: Int, getC :: Int} deriving (Show)
type RoadSystem = [Section]

data Label = A | B | C deriving (Show)
type Path = [(Label, Int)]


heathrowToLondon = 	[
	Section 50 10 30,
	Section 5 90 20,
	Section 40 2 25,
	Section 10 8 0
	]

moveAhead:: (Path, Path) -> Section -> (Path, Path)
moveAhead ((la, da):as, (lb, db):bs) (Section a b c) = (newPathA, newPathB)
	where
		newPathA = 	if (da + a <= db + b + c) 
					then (A, da + a):(la, da):as 
					else (C, db + b + c):(B, db + b):(lb, db):bs
		newPathB = 	if (db + b <= da + a + c)
					then (B, db + b):(lb, db):bs
					else (C, da + a + c):(A, da + a):(la, da):as

takeNearer:: (Path, Path) -> Path
takeNearer ((la, da):as, (lb, db):bs)
	| da < db = (la, da):as
	| otherwise = (lb, db):bs


quickestPath:: RoadSystem -> Path
quickestPath = takeNearer . foldl moveAhead ([(A, 0)], [(B, 0)]) 


groupsOf:: Int -> [a] -> [[a]]
groupsOf _ [] = []
groupsOf n xs = take n xs : groupsOf n $ drop n xs

main = do
	contents <- getContents
	let threes = groupsOf 3 (map read $ lines contents)
		roadMap = map (\[a, b, c] -> Section a b c) threes
		optimalPath = quickestPath roadMap
	show optimalPath


