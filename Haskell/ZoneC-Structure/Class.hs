data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show)

singleton:: a -> Tree a
singleton a = Node a EmptyTree EmptyTree

treeInsert:: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
	| x == a = Node x left right
	| x > a = Node a left (treeInsert x right)
	| x < a = Node a (treeInsert x left) right


class YesNo a where
	yesno:: a -> Bool

instance YesNo Int where
	yesno 0 = False
	yesno _ = True

instance YesNo [a] where
	yesno [] = False
	yesno _ = True

instance YesNo Bool where
	yesno = id

instance YesNo (Maybe a) where
	yesno (Just _) = True
	yesno Nothing = False

yesnoIf:: (YesNo y) => y -> a -> a -> a
yesnoIf yesnoVal yesResult noResult
	| yesno yesnoVal = yesResult
	| otherwise = noResult


class Functor f where
	fmap:: (a -> b) -> f a -> f b



