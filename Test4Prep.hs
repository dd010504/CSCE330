======================================================================
HASKELL TEST 4 PRACTICE

NAME: ________________________________________________________________

General Guidelines:
Rule 1 — Required language feature: If you do not use the required
language feature/function, automatic -50% for that question. Use the
feature if you can see any path forward with it.

Rule 2 — "Using" means doing real work: The required feature must do
something productively toward the solution. Wrappers like
f xs = g [x | x<-xs] where g does all the work do not count as using
a list comprehension.

Rule 3 — Lambda functions: You may want or need a lambda (anonymous)
function for higher-order function problems.

Rule 4 — Helper functions: Always legal. The required feature may
appear in the helper or the primary function.

Rule 5 — This is Haskell: Attempting to write imperative code and
fake Haskell syntax will not receive credit.

======================================================================
Q1. (30 pts, Easy) — List Comprehension

Required: list comprehension

Define pairs :: Int -> [(Int,Int)] that returns all pairs (i,j)
with 1 <= i < j <= n such that i + j is odd.

Examples:
pairs 4  ==  [(1,2),(1,4),(2,3),(3,4)]   -- order may vary
pairs 1  ==  []

ANSWER:

pairs :: Int -> [(Int,Int)]
pairs n = [(x,y)| x <-[1..n], y<-[x+1..n], x+y 'mod' = 1]

======================================================================
Q2. (20 pts, Easy) — Guards, Conditional, or Pattern Matching

Required: guarded equation, conditional expression, OR pattern
matching — your choice.

Define describeList :: [a] -> String that categorises a list by
its length:
length == 0   ->  "empty"
length == 1   ->  "singleton"
length <= 5   ->  "short"
otherwise     ->  "long"

Examples:
describeList []        == "empty"
describeList [1]       == "singleton"
describeList [1,2,3]   == "short"
describeList [1..10]   == "long"

ANSWER:

describeList :: [a] -> String
describeList xs
        | strLength == 0 = "empty"
        | strLength == 1 = "singleton"
        | strLength <= 5 = "short"
        | otherwise = "long"
        where strLength = length xs 

======================================================================
Q3. (40 pts, Easy-Medium) — Any Approach (no HOF required)

Define rotate :: Int -> [a] -> [a] that rotates a list left by n
positions (n may be larger than the list length).

Hint: drop, take, mod, and length are in the Prelude.

Examples:
rotate 2 [1,2,3,4,5]  ==  [3,4,5,1,2]
rotate 0 [1,2,3]      ==  [1,2,3]
rotate 7 [1,2,3]      ==  [2,3,1]   -- 7 mod 3 = 1
rotate 3 []           ==  []

ANSWER:

rotate :: Int -> [a] -> [a]
rotate _ [] = []
rotate n xs = drop trueN xs ++ take trueN xs
  where trueN = n `mod` length xs

======================================================================
Q4. (30 pts, Easy) — map or filter

Required: map, filter, or both (no explicit recursion).

Define scalePositives :: Double -> [Double] -> [Double] that keeps
only the positive numbers in the list and multiplies each by k.

Examples:
scalePositives 3.0 [1.0, -2.0, 0.0, 4.0]  ==  [3.0, 12.0]
scalePositives 2.0 [-1.0, -3.0]           ==  []

ANSWER:

scalePositives :: Double -> [Double] -> [Double]
scalePositives k xs = (map (*k) (filter \x->x >0 ) xs )

======================================================================
Q5. (40 pts, Medium) — foldr (non-list result)

Required: foldr

Define countIf :: (a -> Bool) -> [a] -> Int that counts how many
elements satisfy the predicate, using foldr.

Examples:
countIf even [1,2,3,4,5,6]  ==  3
countIf (>0) [-1,2,-3,4]    ==  2
countIf odd  []             ==  0

ANSWER:

countIf :: (a -> Bool) -> [a] -> Int
countIf p xs = foldr (\x acc -> p x then 1+acc else acc) 0 xs

======================================================================
Q6. (40 pts, Medium) — foldr or Recursion (list result)

Required: foldr OR explicit recursion.

Define intersperse :: a -> [a] -> [a] that inserts a separator
element between every adjacent pair.

Examples:
intersperse 0 [1,2,3,4]  ==  [1,0,2,0,3,0,4]
intersperse ',' "abc"    ==  "a,b,c"
intersperse 9 [7]        ==  [7]
intersperse 9 []         ==  []

ANSWER:

intersperse :: a -> [a] -> [a]
intersperse _ [] = []
intersperse _ [x] = [x]
intersperse sep (x:xs) = x : sep : intersperse sep xs

======================================================================
Q7. (50 pts, Medium-Hard) — Higher-Order Functions Encouraged

Hint: Higher-order functions (map, filter, foldr) are natural here.

Define applyAll :: [a -> b] -> a -> [b] that applies a list of
functions to a single value and collects the results.

Examples:
applyAll [(2), (+10), (\x->xx)] 3  ==  [6, 13, 9]
applyAll [even, odd] 4               ==  [True, False]
applyAll [] 99                       ==  []

Then use applyAll to define allTrue :: [a -> Bool] -> a -> Bool
that returns True iff every predicate in the list holds for the value.

Examples:
allTrue [even, (>0)] 4     ==  True
allTrue [even, (>0)] (-2)  ==  False
allTrue [] 99              ==  True

You may use helper functions.

ANSWER:

applyAll :: [a -> b] -> a -> [b]
applyAll fs x = map(\f->f x) fs

allTrue :: [a -> Bool] -> a -> Bool
allTrue fs x = and (applyAll fs x)

======================================================================
Q8a. (30 pts, Easy+) — Chapter 8 Types: Maybe

Define safeSqrt :: Double -> Maybe Double that returns
Just (sqrt x) if x >= 0, and Nothing otherwise.

Then define safeSqrtPair :: (Double,Double) -> Maybe (Double,Double)
that applies safeSqrt to both components of a pair and returns Just
the pair of roots, or Nothing if either component is negative.

Examples:
safeSqrt 9.0              ==  Just 3.0
safeSqrt (-4.0)           ==  Nothing
safeSqrtPair (4.0, 9.0)   ==  Just (2.0, 3.0)
safeSqrtPair (-1.0, 9.0)  ==  Nothing

ANSWER:

safeSqrt :: Double -> Maybe Double
safeSqrt x 
    | x>0 = Just (sqrt x)
    | otherwise = Nothing

safeSqrtPair :: (Double,Double) -> Maybe (Double,Double)
safeSqrtPair (x,y) = case (safeSqrt x, safeSqrt y) of
    (Just a, Just b) -> Just (a, b)
    _                -> Nothing

======================================================================
Q8b. (45 pts, Medium) — Chapter 8 Types: Tree

Using the Tree a type:
data Tree a = Nil | Leaf a | Node (Tree a) a (Tree a)

Part (i) — treeSum :: Tree Int -> Int
Return the sum of all values in the tree (Nil contributes 0).

Part (ii) — treeMap :: (a -> b) -> Tree a -> Tree b
Apply a function to every value in the tree, preserving structure.

Examples:
-- given: slide21 = Node (Node (Leaf 1) 3 (Leaf 4)) 5 (Node (Leaf 6) 7 (Leaf 9))
treeSum slide21           ==  35
treeSum Nil               ==  0
treeMap (*2) (Leaf 3)     ==  Leaf 6
treeMap (+1) (Node (Leaf 1) 2 (Leaf 3))  ==  Node (Leaf 2) 3 (Leaf 4)

ANSWER:

treeSum :: Tree Int -> Int
treeSum Nil          = 0
treeSum (Leaf x)     = x
treeSum (Node l v r) = treeSum l + v + treeSum r 

treeMap :: (a -> b) -> Tree a -> Tree b
treeMap f Nil          = Nil
treeMap f (Leaf x)     = leaf (f x)
treeMap f (Node l v r) = (treeMap f l) (f v) (treeMap f r)

======================================================================
Q9. (50 pts, Hard) — Any Approach

Define runLengthEncode :: Eq a => [a] -> [(a, Int)] that compresses
a list into (element, count) pairs of consecutive runs.

Examples:
runLengthEncode "aaabbbccddddee"  ==  [('a',3),('b',3),('c',2),('d',4),('e',2)]
runLengthEncode [1,1,2,2,2,3]     ==  [(1,2),(2,3),(3,1)]
runLengthEncode []                ==  []
runLengthEncode [5]               ==  [(5,1)]

You may use any combination of recursion and/or higher-order functions.

ANSWER:

runLengthEncode :: Eq a => [a] -> [(a, Int)]
runLengthEncode [] = []
runLengthEncode (x:xs) = (x, length (takeWhile (== x) (x:xs))) : runLengthEncode (dropWhile (== x) xs

======================================================================