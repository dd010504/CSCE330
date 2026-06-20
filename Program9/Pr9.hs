module Pr9 where

-- ============================================================
-- CSCE 330 — Programming Assignment 9
-- Fill in every stub below.  Do NOT change type signatures.
-- ============================================================


-- ============================================================
-- Part A — Classwork-style problems (Chapters 4–7)
-- ============================================================

-- ------------------------------------------------------------
-- Problem 1: digits
-- Returns the list of digits of a non-negative integer.
-- Required construct: list comprehension
-- Example: digits 1729 == [1,7,2,9]
--          digits 0    == [0]
-- ------------------------------------------------------------

digits :: Int -> [Int]
digits n = [read [d] | d <- show n]

digits' :: Int -> [Int]
digits' n = map (\d -> read [d]) (show n)

-- ------------------------------------------------------------
-- Problem 2: bmi
-- Given weight (kg) and height (m), return a classification.
-- Required construct: guards, conditional, or pattern matching
--   < 18.5           -> "Underweight"
--   18.5 <= bmi < 25 -> "Normal"
--   25   <= bmi < 30 -> "Overweight"
--   >= 30            -> "Obese"
-- Example: bmi 70 1.75 == "Normal"
-- ------------------------------------------------------------

bmi :: Double -> Double -> String
bmi w h
    | b < 18.5  = "Underweight"
    | b < 25.0  = "Normal"
    | b < 30.0  = "Overweight"
    | otherwise = "Obese"
  where b = w / (h * h)


bmi' :: Double -> Double -> String
bmi' w h = 
    let b = w / (h * h) in
    if b < 18.5 then "Underweight"
    else if b < 25.0 then "Normal"
    else if b < 30.0 then "Overweight"
    else "Obese"


-- ------------------------------------------------------------
-- Problem 3: safeHead
-- Returns Just the first element, or Nothing for an empty list.
-- Any approach allowed.
-- Example: safeHead [1,2,3] == Just 1
--          safeHead []      == Nothing
-- ------------------------------------------------------------
safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

safeHead' :: [a] -> Maybe a
safeHead' xs = if null xs then Nothing else Just (head xs)

-- ------------------------------------------------------------
-- Problem 4: zipWithIndex
-- Pairs each element with its 0-based index.
-- Required construct: map and/or zip (no explicit recursion)
-- Example: zipWithIndex "abc" == [(0,'a'),(1,'b'),(2,'c')]
-- ------------------------------------------------------------

zipWithIndex :: [a] -> [(Int, a)]
zipWithIndex xs = zip [0..] xs

zipWithIndex' :: [a] -> [(Int, a)]
zipWithIndex' xs = zip [0 .. length xs - 1] xs

-- ------------------------------------------------------------
-- Problem 5: mySum / mySum'
-- Returns the sum of a list (sum of [] is 0).
-- Required construct: foldl or foldr (one each)
-- Note: 'sum' exists in the Prelude, so we name these mySum/mySum'
-- Example: mySum [1..5] == 15
-- ------------------------------------------------------------

mySum :: [Int] -> Int
mySum xs = foldl (+) 0 xs

mySum' :: [Int] -> Int
mySum' xs = foldr (+) 0 xs

-- ------------------------------------------------------------
-- Problem 6: wordsOfLength
-- Returns only the words (space-separated tokens) whose length
-- equals n.
-- Required construct: filter (no explicit recursion)
-- Example: wordsOfLength 3 "the cat sat on a mat" == ["the","cat","sat","mat"]
-- Hint: 'words' splits a String into tokens.
-- ------------------------------------------------------------

wordsOfLength :: Int -> String -> [String]
wordsOfLength n s = filter (\w -> length w == n) (words s)

wordsOfLength' :: Int -> String -> [String]
wordsOfLength' n = filter ((== n) . length) . words

-- ============================================================
-- Part B — Chapter 8 algebraic data types
-- ============================================================

-- ---------- Nat ----------

data Nat = Zero | Succ Nat deriving Show

nat2int :: Nat -> Int
nat2int Zero     = 0
nat2int (Succ n) = 1 + nat2int n

int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat n = Succ (int2nat (n - 1))

-- ------------------------------------------------------------
-- Problem 7: subNat
-- Subtraction on Nat.  If m < n the result is Zero (saturating).
-- Example: nat2int (subNat (int2nat 5) (int2nat 3)) == 2
--          nat2int (subNat (int2nat 2) (int2nat 5)) == 0
-- ------------------------------------------------------------
subNat :: Nat -> Nat -> Nat
subNat m Zero = m
subNat Zero _ = Zero
subNat (Succ m) (Succ n) = subNat m n

-- ---------- Expr ----------

data Expr = Val Int
           | Add Expr Expr
           | Mul Expr Expr
           deriving Show

-- ------------------------------------------------------------
-- Problem 8: eval
-- Evaluates an Expr to an Int.
-- Example: eval (Add (Val 2) (Mul (Val 3) (Val 4))) == 14
-- ------------------------------------------------------------

eval :: Expr -> Int
eval (Val n)     = n
eval (Add e1 e2) = eval e1 + eval e2
eval (Mul e1 e2) = eval e1 * eval e2


-- ------------------------------------------------------------
-- Problem 9: exprDepth
-- Returns the maximum depth (number of nested constructors)
-- of an Expr.
-- Val n has depth 1.
-- Add/Mul has depth 1 + max depth of its two sub-expressions.
-- Example: exprDepth (Val 5)                             == 1
--          exprDepth (Add (Val 1) (Val 2))               == 2
--          exprDepth (Mul (Add (Val 1) (Val 2)) (Val 3)) == 3
-- ------------------------------------------------------------

exprDepth :: Expr -> Int
exprDepth (Val _)     = 1
exprDepth (Add e1 e2) = 1 + max (exprDepth e1) (exprDepth e2)
exprDepth (Mul e1 e2) = 1 + max (exprDepth e1) (exprDepth e2)


-- ---------- Tree ----------

data Tree a = Nil
             | Leaf a
             | Node (Tree a) a (Tree a)
             deriving Show

-- ------------------------------------------------------------
-- Problem 10: treeToList
-- In-order traversal: left subtree, root, right subtree.
-- Nil contributes nothing; Leaf x contributes [x].
-- Example: treeToList (Node (Leaf 1) 2 (Leaf 3)) == [1,2,3]
-- ------------------------------------------------------------
treeToList :: Tree a -> [a]
treeToList Nil          = []
treeToList (Leaf x)     = [x]
treeToList (Node l x r) = treeToList l ++ [x] ++ treeToList r

-- ============================================================
-- Part C — HigherOrder functions
-- (HigherOrder module content folded in below)
-- ============================================================

-- ------------------------------------------------------------
-- Problem 11: split
-- Splits a list into chunks of exactly n elements.
-- Returns Nothing if the list length is not divisible by n,
-- or if n <= 0.
-- Example: split 3 [1..9] == Just [[1,2,3],[4,5,6],[7,8,9]]
--          split 4 [1..9] == Nothing
-- ------------------------------------------------------------

split :: Int -> [a] -> Maybe [[a]]
split n xs
    | n <= 0 = Nothing
    | length xs `mod` n /= 0 = Nothing
    | otherwise = Just (chunk n xs)
  where
    chunk _ [] = []
    chunk k ys = take k ys : chunk k (drop k ys)


-- ------------------------------------------------------------
-- Problem 12: isRepeats (recursive)
-- Returns True iff xs can be split into chunks of size n that
-- are all equal to each other.
-- Example: isRepeats 3 [1,2,3,1,2,3] == True
--          isRepeats 2 [1,2,3,4]     == False
-- ------------------------------------------------------------

isRepeats :: Eq a => Int -> [a] -> Bool
isRepeats _ [] = False  -- Protects against empty lists
isRepeats n xs
    | n <= 0 = False
    | length xs `mod` n /= 0 = False
    | otherwise = let c = take n xs in go c (drop n xs)
  where
    go _ [] = True
    go c ys = take n ys == c && go c (drop n ys)


-- ------------------------------------------------------------
-- Problem 13: isRepeats' (map / filter)
-- Same semantics as isRepeats, implemented with map and/or filter.
-- ------------------------------------------------------------

isRepeats' :: Eq a => Int -> [a] -> Bool
isRepeats' _ [] = False -- Protects against empty lists
isRepeats' n xs = case split n xs of
    Nothing     -> False
    Just []     -> False
    Just (c:cs) -> length (filter (== c) cs) == length cs

-- ------------------------------------------------------------
-- Problem 14: isRepeats'' (foldr)
-- Same semantics as isRepeats, implemented with foldr.
-- ------------------------------------------------------------

isRepeats'' :: Eq a => Int -> [a] -> Bool
isRepeats'' _ [] = False -- Protects against empty lists
isRepeats'' n xs = case split n xs of
    Nothing     -> False
    Just []     -> False
    Just (c:cs) -> foldr (\x acc -> (x == c) && acc) True cs


-- ------------------------------------------------------------
-- Problem 15: repeats
-- Returns the LONGEST prefix s such that xs == s ++ s ++ ...
-- (two or more copies).  Returns Nothing if no such prefix exists.
-- Example: repeats [1,2,1,2,1,2,1,2] == Just [1,2,1,2]
--          repeats [1,2,1,2]         == Just [1,2]
--          repeats [1,2,3]           == Nothing
-- NOTE: "longest" means the biggest chunk, i.e. half the list
--       for exactly two copies.
-- ------------------------------------------------------------
repeats :: Eq a => [a] -> Maybe [a]
repeats [] = Nothing
repeats xs = findRepeat (length xs `div` 2)
  where
    findRepeat 0 = Nothing
    findRepeat k
      | length xs `mod` k == 0 && all (== take k xs) (chunks k xs) = Just (take k xs)
      | otherwise = findRepeat (k - 1)
    
    chunks _ [] = []
    chunks n ys = take n ys : chunks n (drop n ys)