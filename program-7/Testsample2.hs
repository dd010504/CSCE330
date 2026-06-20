grade :: (Num a, Ord a) => a -> String
grade n 
    | n >= 90   = "A" 
    | n >= 80   = "B"
    | otherwise = "C"