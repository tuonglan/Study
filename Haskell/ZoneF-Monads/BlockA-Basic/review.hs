import Control.Applicative

main = do
	a <- (++) <$> getLine <*> getLine
	putStrLn $ "The two lines concatenate turn out to be: " ++ a

sequenceA' :: (Applicative f) => [f a] -> f [a]
sequenceA' = foldr (liftA2 (:)) (pure [])

sequenceA''::(Applicative f) => [f a] -> f [a]
sequenceA'' = foldr (\a b -> (:) <$> a <*> b) (pure [])
