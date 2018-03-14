import qualified Data.Foldable as F

data Tree a = EmptyTree | Branch a (Tree a) (Tree a)
	deriving (Eq, Show)

instance F.Foldable Tree where
	foldMap f EmptyTree = mempty
	foldMap f (Branch x l r) = foldMap f l `mappend` f x `mappend` foldMap f r


isBinaryTree :: (Eq a) => Tree a -> Bool
isBinaryTree EmptyTree = True
isBinaryTree (Branch _ l r) = (isBinaryTree l) && (isBinaryTree r)
isBinaryTree (Branch _ _ _) = False

roundUp :: (Integral b, RealFrac a) => a -> b
roundUp a = round $ a+0.5
roundDown :: (Integral b, RealFrac a) => a -> b
roundDown a = round $ a-0.5

completeBTreeWithChar :: Int -> Char -> Tree Char
completeBTreeWithChar 0 _ = EmptyTree
completeBTreeWithChar 1 c = Branch c EmptyTree EmptyTree
completeBTreeWithChar n c = Branch c (completeBTreeWithChar lN c) (completeBTreeWithChar rN c)
	where
		lN = (n-1) - (div (n-1) 2)
		rN = div (n-1) 2

completeBTree :: Int -> Tree Int
completeBTree 0 = EmptyTree
completeBTree n = Branch n (completeBTree $ n `div` 2) (completeBTree $ n `div` 2)

leaf :: (Eq a) => a -> Tree a
leaf c = Branch c EmptyTree EmptyTree

cbalTree :: (Eq a) => Int -> a -> [Tree a]
cbalTree 0 _ = [EmptyTree]
cbalTree 1 c = [leaf c]
cbalTree n c = 	if (mod n 2 == 1) then
					[Branch c l r | l <- cbalTree (div n 2) c,
									r <- cbalTree (div n 2) c]
				else
					concat [[Branch c l r, Branch c r l] | 	l <- cbalTree (div (n-1) 2) c,
															r <- cbalTree (div n 2) c]

flipBTree :: (Eq a) => Tree a -> Tree a
flipBTree EmptyTree = EmptyTree
flipBTree (Branch x EmptyTree EmptyTree) = Branch x EmptyTree EmptyTree
flipBTree (Branch n l r) = Branch n (flipBTree r) (flipBTree l)

equalCheck :: (Eq a) => Tree a -> Tree a -> Bool
equalCheck EmptyTree EmptyTree = True
equalCheck EmptyTree _ = False
equalCheck _ EmptyTree = False
equalCheck (Branch n1 l1 r1) (Branch n2 l2 r2) =
	n1 == n2
	&& equalCheck l1 l2
	&& equalCheck r1 r2

symetricCheck :: (Eq a) => Tree a -> Bool
symetricCheck EmptyTree = True
symetricCheck (Branch n l r) = equalCheck l $ flipBTree r




