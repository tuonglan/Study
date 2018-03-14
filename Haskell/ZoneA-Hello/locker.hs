import qualified Data.Map as Map

data LockerState = Taken | Free deriving(Show, Eq)
type Code = String
type LockerMap = Map.Map Int (LockerState, Code)


lockerLookup :: Int -> LockerMap -> Either Code String
lockerLookup num map = case Map.lookup num map of
    Nothing -> Right $ "Locker number " ++ show num ++ " doesn't exist!"
    Just (state, code) -> if state == Taken
                            then Right $ "Locker number " ++ show num ++ " is taken!"
                            else Left code

