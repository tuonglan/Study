data BTree a = Null | Node a (BTree a) (BTree a)
    deriving (Show, Read)

instance Functor BTree where
    fmap f Null = Null
    fmap f (Node v left right) = Node (f v) (fmap f left) (fmap f right)


-- Binary Tree Functions --
treeInsert :: (Ord a) => a -> BTree a -> BTree a
treeInsert x Null = Node x Null Null
treeInsert x (Node v left right)
    | x >= v = Node v left (treeInsert x right)
    | x < v = Node v (treeInsert x left) right

treeElem :: (Ord a) => a -> BTree a -> Bool
treeElem x (Node v left right)
    | x == v = True
    | x > v = treeElem x right
    | x < v = treeElem x left



