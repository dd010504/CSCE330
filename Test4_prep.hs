{- 
  CSCE 330 — Test 4 Practice Questions [cite: 1]
  Replace `undefined` with your actual code to test it in GHCi.
-}

-- Provided Algebraic Data Type for Q8b [cite: 18]
data Tree a = Nil | Leaf a | Node (Tree a) a (Tree a) deriving Show [cite: 19]

{- ==================================================================
   Q1 (30 pts, Easy) — List Comprehension [cite: 20]
   Required: list comprehension [cite: 21]
   Goal: Define pairs :: Int -> [(Int,Int)] [cite: 22]
   Details: Return all pairs (i,j) with 1 <= i < j <= n such that i + j is odd[cite: 23].
   Examples:
     pairs 4  ==  [(1,2),(1,4),(2,3),(3,4)] [cite: 24]
     pairs 1  ==  [] [cite: 24]
================================================================== -}
pairs :: Int -> [(Int,Int)]
pairs n = [(x,y) | x <- [1..n], y <- [x+1..n], odd (x+y)]

{- ==================================================================
   Q2 (20 pts, Easy) — Guards, Conditional, or Pattern Matching [cite: 27]
   Required: guarded equation, conditional expression, OR pattern matching[cite: 28].
   Goal: Define describeList :: [a] -> String [cite: 29]
   Details: Categorize a list by its length: [cite: 30]
            length == 0 -> "empty" [cite: 31]
            length == 1 -> "singleton" [cite: 31]
            length <= 5 -> "short" [cite: 31]
            otherwise   -> "long" [cite: 31]
   Examples:
     describeList []        == "empty" [cite: 32]
     describeList [1]       == "singleton" [cite: 33]
     describeList [1,2,3]   == "short" [cite: 34]
     describeList [1..10]   == "long" [cite: 35]
================================================================== -}
describeList :: [a] -> String
describeList xs 
    | length xs == 0 = "empty"
    | length xs == 1 = "singleton"
    | length xs <= 5 = "short"
    | otherwise      = "long"

{- ==================================================================
   Q3 (40 pts, Easy-Medium) — Any Approach (no HOF required) [cite: 37]
   Goal: Define rotate :: Int -> [a] -> [a] [cite: 38]
   Details: Rotate a list left by n positions (n may be larger than the list length)[cite: 39].
   Examples:
     rotate 2 [1,2,3,4,5]  ==  [3,4,5,1,2] [cite: 40]
     rotate 0 [1,2,3]      ==  [1,2,3] [cite: 40]
     rotate 7 [1,2,3]      ==  [2,3,1]   -- 7 mod 3 = 1 [cite: 40]
================================================================== -}
rotate :: Int -> [a] -> [a]
rotate _ [] = []  -- Handle the empty list edge case to prevent divide-by-zero
rotate n xs = drop trueN xs ++ take trueN xs
  where 
    trueN = n `mod` length xs

{- ==================================================================
   Q4 (30 pts, Easy) — map or filter [cite: 43]
   Required: map, filter, or both (no explicit recursion)[cite: 44].
   Goal: Define scalePositives :: Double -> [Double] -> [Double] [cite: 45]
   Details: Keep only the positive numbers in the list and multiply each by k[cite: 46].
   Examples:
     scalePositives 3.0 [1.0, -2.0, 0.0, 4.0]  ==  [3.0, 12.0] [cite: 47]
     scalePositives 2.0 [-1.0, -3.0]           ==  [] [cite: 47]
================================================================== -}
scalePositives :: Double -> [Double] -> [Double]
scalePositives k xs = map (* k) (filter (> 0) xs)

{- ==================================================================
   Q5 (40 pts, Medium) — foldr (non-list result) [cite: 49]
   Required: foldr [cite: 50]
   Goal: Define countIf :: (a -> Bool) -> [a] -> Int [cite: 51]
   Details: Count how many elements satisfy the predicate, using foldr[cite: 52].
   Examples:
     countIf even [1,2,3,4,5,6]  ==  3 [cite: 53]
     countIf (>0) [-1,2,-3,4]    ==  2 [cite: 53]
================================================================== -}
countIf :: (a -> Bool) -> [a] -> Int
countIf p xs = undefined

{- ==================================================================
   Q6 (40 pts, Medium) — foldr or Recursion (list result) [cite: 55]
   Required: foldr OR explicit recursion[cite: 56].
   Goal: Define intersperse :: a -> [a] -> [a] [cite: 57]
   Details: Insert a separator element between every adjacent pair[cite: 58].
   Examples:
     intersperse 0 [1,2,3,4]  ==  [1,0,2,0,3,0,4] [cite: 59]
     intersperse ',' "abc"    ==  "a,b,c" [cite: 59]
================================================================== -}
countIf :: (a -> Bool) -> [a] -> Int
countIf p xs = foldr (\x acc -> if p x then 1 + acc else acc) 0 xs

{- ==================================================================
   Q7 (50 pts, Medium-Hard) — Higher-Order Functions [cite: 61]
   Goal 1: Define applyAll :: [a -> b] -> a -> [b] [cite: 63]
   Details 1: Apply a list of functions to a single value and collect the results[cite: 64].
   Goal 2: Define allTrue :: [a -> Bool] -> a -> Bool [cite: 66]
   Details 2: Return True iff every predicate in the list holds for the value[cite: 67].
   Examples:
     applyAll [(*2), (+10), (\x->x*x)] 3  ==  [6, 13, 9] [cite: 65]
     allTrue [even, (>0)] 4               ==  True [cite: 68]
================================================================== -}
applyAll :: [a -> b] -> a -> [b]
applyAll fs x = map (\f -> f x) fs


allTrue :: [a -> Bool] -> a -> Bool
allTrue fs x = and (applyAll fs x)

{- ==================================================================
   Q8a (30 pts, Easy+) — Chapter 8 Types: Maybe [cite: 71]
   Goal 1: Define safeSqrt :: Double -> Maybe Double [cite: 72]
   Details 1: Return Just (sqrt x) if x >= 0, and Nothing otherwise[cite: 73].
   Goal 2: Define safeSqrtPair :: (Double,Double) -> Maybe (Double,Double) [cite: 74]
   Details 2: Apply safeSqrt to both components of a pair and return Just the pair of roots, or Nothing if either component is negative[cite: 75].
   Examples:
     safeSqrt 9.0              ==  Just 3.0 [cite: 76]
     safeSqrtPair (4.0, 9.0)   ==  Just (2.0, 3.0) [cite: 76]
================================================================== -}
safeSqrt :: Double -> Maybe Double
safeSqrt x
    | x >= 0    = Just (sqrt x)
    | otherwise = Nothing

safeSqrtPair :: (Double, Double) -> Maybe (Double, Double)
safeSqrtPair (x, y) = 
    case (safeSqrt x, safeSqrt y) of
        (Just rootX, Just rootY) -> Just (rootX, rootY)
        _                        -> Nothing

{- ==================================================================
   Q8b (45 pts, Medium) — Chapter 8 Types: Tree [cite: 78]
   Goal 1: Define treeSum :: Tree Int -> Int [cite: 80]
   Details 1: Return the sum of all values in the tree (Nil contributes 0)[cite: 81].
   Goal 2: Define treeMap :: (a -> b) -> Tree a -> Tree b [cite: 82]
   Details 2: Apply a function to every value in the tree, preserving structure[cite: 83].
================================================================== -}
treeSum :: Tree Int -> Int
treeSum t = undefined

treeMap :: (a -> b) -> Tree a -> Tree b
treeMap f t = undefined

{- ==================================================================
   Q9 (50 pts, Hard) — Any Approach [cite: 86]
   Goal: Define runLengthEncode :: Eq a => [a] -> [(a, Int)] [cite: 87]
   Details: Compress a list into (element, count) pairs of consecutive runs[cite: 88].
   Examples:
     runLengthEncode "aaabbbccddddee"  ==  [('a',3),('b',3),('c',2),('d',4),('e',2)] [cite: 89]
     runLengthEncode [1,1,2,2,2,3]     ==  [(1,2),(2,3),(3,1)] [cite: 89]
================================================================== -}
runLengthEncode :: Eq a => [a] -> [(a, Int)]
runLengthEncode xs = undefined