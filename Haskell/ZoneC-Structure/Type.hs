data Shape' = Circle' Float Float Float | Rectangle' Float Float Float Float
	deriving (Show)


area:: Shape' -> Float
area (Circle' _ _ r) = pi * r^2
area (Rectangle' x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)


data Point = Point Float Float deriving (Show)
data Shape = Circle Point Float | Rectangle Point Point
	deriving (Show)


nudge:: Shape -> Float -> Float -> Shape
nudge (Circle (Point x y) r) a b = Circle (Point (x + a) (y + b) ) r
nudge (Rectangle (Point x1 y1) (Point x2 y2)) a b = Rectangle (Point (x1 + a) (y1 + b)) (Point (x2 + a) (y2 + b))


data StringMaybe = SNothing | String
data Car = Car {
	company:: String,
	model:: String,
	year:: Int
} deriving (Show)

tellCar :: Car -> String
tellCar (Car {company = c, model = m, year = y}) = "This " ++ c ++ " " ++ m ++ " was made in " ++ show y


data Vector a = Vector a a a deriving (Show)

vPlus :: (Num a) => Vector a -> Vector a -> Vector a
vPlus (Vector i j k) (Vector l m n) = Vector (i+l) (j+m) (k+n)

dotProd :: (Num a) => Vector a -> Vector a -> a
dotProd (Vector i j k) (Vector l m n) = i+l + j*m + k*n

vMult :: (Num a) => Vector a -> a -> Vector a
vMult (Vector i j k) m = Vector (i*m) (j*m) (k*m)


data Person = Person {
	firstName:: String,
	lastName:: String,
	age:: Int
} deriving (Eq, Show, Read)

mikeD = Person "Michael" "Diamond" 43
adRock = Person "Adam" "Horovitz" 41
mca = Person {firstName = "Adam", lastName = "Yauch", age = 44}


data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
	deriving (Eq, Ord, Show, Read, Bounded, Enum)

data Either a b = Left a | Right b deriving (Eq, Ord, Read, Show)

infixr 5 :-:
data List a = Empty | a :-: (List a) deriving (Show, Read, Eq, Ord)



