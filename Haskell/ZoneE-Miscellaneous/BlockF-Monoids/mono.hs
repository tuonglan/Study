import qualified Data.Foldable as F

newtype Any = Any {getAny :: Bool}
	deriving (Eq, Ord, Show, Read, Bounded)
newtype All = All {getAll :: Bool}
	deriving (Eq, Ord, Show, Read, Bounded)

instance Monoid Any where
	mempty = Any False
	mappend (Any x) (Any y) = Any (x || y)
instance Monoid All where
	mempty = All True
	mappend (All x) (All y) = All (x && y)

data Tree a = EmptyTree | Node a (Tree a) (Tree a)
	deriving (Show)
instance F.Foldable Tree where
	foldMap f EmptyTree = mempty
	foldMap f (Node x l r) = F.foldMap f l `mappend` f x `mappend` F.foldMap f r
