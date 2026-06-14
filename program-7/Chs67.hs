module Chs67 where

import Data.Char (digitToInt)

-- 1. sumdown (3 points for type, 10 points for test)
sumdown :: (Num a, Ord a) => a -> a
sumdown n
  | n <= 0    = 0
  | otherwise = n + sumdown (n - 1)

-- 2. euclid (3 points for type, 12 points for test)
euclid :: Integral a => a -> a -> a
euclid x y
  | x == y    = x
  | x < y     = euclid x (y - x)
  | otherwise = euclid (x - y) y

-- 3. sum' (3 points for type, 6 points for test)
sum' :: Num a => [a] -> a
sum' []     = 0
sum' (x:xs) = x + sum' xs

-- 4. take' (3 points for type, 9 points for test)
take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _      | n <= 0 = []
take' _ []              = []
take' n (x:xs)          = x : take' (n - 1) xs

-- 5. last' (3 points for type, 6 points for test)
last' :: [a] -> a
last' []     = error "Empty list"
last' [x]    = x
last' (_:xs) = last' xs

-- 6. dec2int' (3 points for type, 3 points for test)
dec2int' :: [Int] -> Int
dec2int' = foldl (\acc d -> acc * 10 + d) 0

-- 7. altmap (3 points for type, 5 points for test)
altmap :: (a -> b) -> (a -> b) -> [a] -> [b]
altmap _ _ []        = []
altmap f g (x:y:zs)  = f x : g y : altmap f g zs
altmap f _ [x]       = [f x]

-- 8. luhn (3 points for type, 5 points for test)
luhnDouble :: Int -> Int
luhnDouble x = let doubled = x * 2 
               in if doubled > 9 then doubled - 9 else doubled

luhn :: [Int] -> Bool
luhn xs = sum (altmap id luhnDouble (reverse xs)) `mod` 10 == 0
