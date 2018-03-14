data Accountant = Accountant { age :: Int, name :: String } deriving (Show)
newtype CharList = CharList { getCharList :: [Char] } deriving (Eq, Show)
data Circle a = Circle a deriving (Show)
data Point a = Point a deriving (Show)
newtype Pair b a = Pair {getPair :: (a, b)}

instance Functor Circle where
	fmap f (Circle c) = Circle (f c)
instance Functor (Pair p) where
	fmap f (Pair (x, y)) = Pair (f x, y)
instance Functor Point where
	fmap f (Point p) = Point (f p)


data CoolBool = CoolBool {getCoolBool :: Bool} deriving (Show)
newtype NiceBool = NiceBool {getNiceBool :: Bool} deriving (Show)
helloMe :: CoolBool -> String
helloMe (CoolBool _) = "Hello World"
helloYou :: NiceBool -> String
helloYou (NiceBool _) = "Hello you"
