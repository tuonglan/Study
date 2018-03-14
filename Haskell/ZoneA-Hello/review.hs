import qualified Data.List as List
import qualified Data.Char as Char
import qualified Data.Map as Map

words' :: String -> [String]
words' = foldr word [[]]
  where word ' ' ([]:xs) = []:xs
        word ' ' (x:xs) = []:x:xs
        word c (x:xs) = (c:x):xs

isIn :: (Eq a) => [a] -> [a] -> Bool
isIn needle haystack = any (List.isPrefixOf needle) (List.tails haystack)


-- Find the first number satisfying sum of its digits equal k
sumOfDigit :: Int -> Int
sumOfDigit = sum . map Char.digitToInt . show

sumOfDigitEqual :: Int -> Maybe Int
sumOfDigitEqual k = List.find (\x -> sumOfDigit x == k) [1..]


-- Find key --
findKey :: (Eq k) => k -> [(k, a)] -> Maybe a
findKey key = foldr f Nothing
  where f (k, v) acc
             | key == k = Just v
             | otherwise = acc


-- Map --
phoneBook :: Map.Map String String
phoneBook = Map.fromList $
    [("Lan", "010-9691-1989")
    ,("Do", "222-4444-5555")
    ,("None", "111-000-11")
    ]
