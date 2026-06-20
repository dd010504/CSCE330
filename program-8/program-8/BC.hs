module BC where

--indexInto returns the index of the first argument in a list 
--(don't worry about error checking -- can assume in list)
indexInto :: Eq a => a -> [a] -> Int
indexInto x (y:ys)
  | x == y    = 0
  | otherwise = 1 + indexInto x ys

--converts a character into its corresponding integer value
-- e.g. '0' to 0, 'A' to 10, 'Z' to 35 
-- like hex, except with more digits
-- (consider using elem -- look it up)
dig2Int :: Char -> Int
dig2Int dChar
  | dChar >= '0' && dChar <= '9' = fromEnum dChar - fromEnum '0'
  -- Handles 'A'..'Z' by converting to uppercase manually if necessary
  -- Thanks stack overflow counter #5
  | dChar >= 'a' && dChar <= 'z' = fromEnum dChar - fromEnum 'a' + 10
  | otherwise = fromEnum dChar - fromEnum 'A' + 10

--converts an integer in range 0..35 into its 
-- corresponding digit (0,1..Z)
-- again, don't care about ints out of bounds
num2char :: Int -> Char
num2char n
  | n >= 0 && n <= 9 = toEnum (n + fromEnum '0')
  | otherwise = toEnum (n - 10 + fromEnum 'A')


--converts an integer value to a string representing
-- the number in base b
-- suggest looking up repeated division strategy
-- for how to convert base 10 to binary and 
-- then generalize
int2Base :: Int -> Int -> String
int2Base n b
  | n < b     = [num2char n]
  | otherwise = int2Base (n `div` b) b ++ [num2char (n `mod` b)]

--convert a number string in base b1 into an Int
-- can assume input is valid
valNumString :: String -> Int -> Int
valNumString xs b1 = foldl (\acc x -> acc * b1 + dig2Int x) 0 xs

--convert String of numbers in base b1 into 
-- equivalent value in base b2, as a String
-- again, all input will be valid
convert :: String -> Int -> Int -> String
convert numString b1 b2 = int2Base (valNumString numString b1) b2