import qualified Data.List as DL
import qualified Data.Char as DC
import qualified Data.Map as Map


numUniques:: (Eq a) => [a] -> Int
numUniques = length . DL.nub

wordNums:: String -> [(String, Int)]
wordNums = map (\ws -> (head ws, length ws)) . DL.group . DL.sort . DL.words

isIn:: (Eq a) => [a] -> [a] -> Bool
isIn x y = any ( `DL.isPrefixOf` y) $ DL.tails x

encode:: Int -> String -> String
encode offset msg = map (\c -> DC.chr $ DC.ord c + offset) msg

findKey:: (Eq k) => k -> [(k, v)] -> Maybe v
findKey k = foldr f Nothing
	where f (key, value) acc
		| k == key = Just value
		| otherwise = acc

phoneBook:: Map.Map String String
phoneBook = Map.fromListWith $
	[
	("betty", "555-2938"),
	("betty", "342-2492"),
	("bonnie", "452-2928"),
	("patsy", "493-2928"),
	("pasty", "943-2928"),
	("lucille", "205-2928"),
	("wendy", "939-8282"),
	("penny", "853-2492")
	]

string2Digits :: String -> [Int]
string2Digits = map DC.digitToInt . filter DC.isDigit














