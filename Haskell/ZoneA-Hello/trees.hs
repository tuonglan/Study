module Trees (BTree(..)) where

data Point = FPoint Float Float deriving (Show)
data Shape = Circle Point Float | Rectangle Point Point
    deriving (Show)

data Car = Car  { company :: String
                , model :: String
                , year :: Int
                } deriving (Show)

data Vector a = Vector a a a deriving (Show)


-- Functions --a
area :: Shape -> Float
area (Circle _ r) = pi * r^2

vplus :: (Num a) => Vector a -> Vector a -> Vector a
vplus (Vector i j k) (Vector l m n) = Vector (i+l) (j+m) (k+n)

vmul :: (Num a) => Vector a -> a -> Vector a
vmul (Vector i j k) m = Vector (i*m) (j*m) (k*m)

dotProd :: (Num a) => Vector a -> Vector a -> a
dotProd (Vector i j k) (Vector l m n) = i*l + j*m + k*n




