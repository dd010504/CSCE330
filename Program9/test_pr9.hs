-- ============================================================
-- CSCE 330 — Programming Assignment 9  ** TEST SCRIPT **
-- Total: 50 points
--   Part A (Problems 1–6):  2 pts each  (1 per implementation) = 12
--   Part B (Problems 7–10): 4 pts each                         = 16
--   Part C (Problems 11–14):4 pts each, Problem 15: 6 pts      = 22
-- Run:   ghc -o test_pr9 test_pr9.hs && ./test_pr9
-- ============================================================

import Pr9
import Debug.Trace

main :: IO ()
main = do
  let total = score
  putStrLn $ "Total score: " ++ show total ++ " / 50"

score :: Int
score =
  p1  + p2  + p3  + p4  + p5  +
  p6  + p7  + p8  + p9  + p10 +
  p11 + p12 + p13 + p14 + p15

-- ===========================================================
-- Helpers
-- ===========================================================

testList :: (Show a, Show b, Eq b)
         => String -> (a -> b) -> [(a, b)] -> Int -> Int
testList msg _ [] pts = trace (msg ++ ": passed!") pts
testList msg f ((arg,exp):rest) pts
  | result == exp = testList msg f rest pts
  | otherwise     = trace (msg ++ "  input=" ++ show arg ++
                           "  got=" ++ show result ++
                           "  expected=" ++ show exp) 0
  where result = f arg

testList2 :: (Show a, Show b, Show c, Eq c)
          => String -> (a -> b -> c) -> [(a, b, c)] -> Int -> Int
testList2 msg _ []               pts = trace (msg ++ ": passed!") pts
testList2 msg f ((a,b,exp):rest) pts
  | result == exp = testList2 msg f rest pts
  | otherwise     = trace (msg ++ "  input=(" ++ show a ++ ", " ++ show b ++
                           ")  got=" ++ show result ++
                           "  expected=" ++ show exp) 0
  where result = f a b

-- ===========================================================
-- Part A — Classwork-style problems  (1 pt per implementation)
-- ===========================================================

-- Problem 1: digits  (2 pts)
p1 :: Int
p1 =
  testList "P1  digits " digits
    [ (1729, [1,7,2,9])
    , (0,    [0])
    , (42,   [4,2])
    , (100,  [1,0,0])
    ] 1
  +
  testList "P1  digits'" digits'
    [ (1729, [1,7,2,9])
    , (0,    [0])
    , (42,   [4,2])
    , (100,  [1,0,0])
    ] 1


-- Problem 2: bmi  (2 pts)
p2 :: Int
p2 =
  testList2 "P2  bmi " bmi
    [ (50.0,  1.70, "Underweight")
    , (70.0,  1.75, "Normal")
    , (85.0,  1.75, "Overweight")
    , (110.0, 1.75, "Obese")
    ] 1
  +
  testList2 "P2  bmi'" bmi'
    [ (50.0,  1.70, "Underweight")
    , (70.0,  1.75, "Normal")
    , (85.0,  1.75, "Overweight")
    , (110.0, 1.75, "Obese")
    ] 1


-- Problem 3: safeHead  (2 pts)
p3 :: Int
p3 =
  testList "P3  safeHead " (safeHead :: [Int] -> Maybe Int)
    [ ([1,2,3], Just 1)
    , ([],      Nothing)
    , ([99],    Just 99)
    ] 1
  +
  testList "P3  safeHead'" (safeHead' :: [Int] -> Maybe Int)
    [ ([1,2,3], Just 1)
    , ([],      Nothing)
    , ([99],    Just 99)
    ] 1


-- Problem 4: zipWithIndex  (2 pts)
p4 :: Int
p4 =
  testList "P4  zipWithIndex " (zipWithIndex :: [Char] -> [(Int,Char)])
    [ ("abc", [(0,'a'),(1,'b'),(2,'c')])
    , ("",    [])
    , ("x",   [(0,'x')])
    ] 1
  +
  testList "P4  zipWithIndex'" (zipWithIndex' :: [Char] -> [(Int,Char)])
    [ ("abc", [(0,'a'),(1,'b'),(2,'c')])
    , ("",    [])
    , ("x",   [(0,'x')])
    ] 1


-- Problem 5: mySum  (2 pts)
p5 :: Int
p5 =
  testList "P5  mySum " mySum
    [ ([1..5], 15)
    , ([],     0)
    , ([7],    7)
    , ([-3,3], 0)
    ] 1
  +
  testList "P5  mySum'" mySum'
    [ ([1..5], 15)
    , ([],     0)
    , ([7],    7)
    , ([-3,3], 0)
    ] 1


-- Problem 6: wordsOfLength  (2 pts)
p6 :: Int
p6 =
  testList2 "P6  wordsOfLength " wordsOfLength
    [ (3, "the cat sat on a mat", ["the","cat","sat","mat"])
    , (1, "a b c",               ["a","b","c"])
    , (5, "hello world",         ["hello","world"])
    , (4, "hi",                  [])
    ] 1
  +
  testList2 "P6  wordsOfLength'" wordsOfLength'
    [ (3, "the cat sat on a mat", ["the","cat","sat","mat"])
    , (1, "a b c",               ["a","b","c"])
    , (5, "hello world",         ["hello","world"])
    , (4, "hi",                  [])
    ] 1


-- ===========================================================
-- Part B — Chapter 8 algebraic data types  (4 pts each)
-- ===========================================================

-- Problem 7: subNat  (4 pts)
p7 :: Int
p7 =
  testList "P7  subNat " (\(a,b) -> nat2int (subNat (int2nat a) (int2nat b)))
    [ ((5,3), 2)
    , ((2,5), 0)
    , ((0,0), 0)
    , ((4,4), 0)
    , ((7,2), 5)
    ] 4


-- Problem 8: eval  (4 pts)
p8 :: Int
p8 =
  testList "P8  eval " eval
    [ (Val 5,                               5)
    , (Add (Val 2) (Val 3),                5)
    , (Mul (Val 3) (Val 4),               12)
    , (Add (Val 2) (Mul (Val 3) (Val 4)), 14)
    , (Mul (Add (Val 1) (Val 2)) (Val 5), 15)
    ] 4


-- Problem 9: exprDepth  (4 pts)
p9 :: Int
p9 =
  testList "P9  exprDepth " exprDepth
    [ (Val 5,                                                    1)
    , (Add (Val 1) (Val 2),                                     2)
    , (Mul (Add (Val 1) (Val 2)) (Val 3),                       3)
    , (Add (Mul (Val 1) (Add (Val 2) (Val 3))) (Val 4),         4)
    ] 4


-- Problem 10: treeToList  (4 pts)
p10 :: Int
p10 =
  testList "P10 treeToList " (treeToList :: Tree Int -> [Int])
    [ (Nil,                                                         [])
    , (Leaf 7,                                                      [7])
    , (Node (Leaf 1) 2 (Leaf 3),                                   [1,2,3])
    , (Node (Node (Leaf 1) 2 (Leaf 3)) 4 (Node (Leaf 5) 6 Nil),   [1,2,3,4,5,6])
    ] 4


-- ===========================================================
-- Part C — HigherOrder functions  (4 pts each, 6 for repeats)
-- ===========================================================

-- Problem 11: split  (4 pts)
p11 :: Int
p11 =
  testList2 "P11 split " split
    [ (3, [1..9],          Just [[1,2,3],[4,5,6],[7,8,9]])
    , (4, [1..9],          Nothing)
    , (2, [1..4],          Just [[1,2],[3,4]])
    , (1, [1..3],          Just [[1],[2],[3]])
    , (5, ([] :: [Int]),   Just [])
    ] 4


-- Problem 12: isRepeats recursive  (4 pts)
p12 :: Int
p12 =
  testList2 "P12 isRepeats " (isRepeats :: Int -> [Int] -> Bool)
    [ (2, [1,2,1,2],      True)
    , (3, [1,2,3,1,2,3],  True)
    , (2, [1,2,3,4],      False)
    , (4, [1..4]++[1..4], True)
    , (3, [],             False)
    ] 4


-- Problem 13: isRepeats' map/filter  (4 pts)
p13 :: Int
p13 =
  testList2 "P13 isRepeats' " (isRepeats' :: Int -> [Int] -> Bool)
    [ (2, [1,2,1,2],      True)
    , (3, [1,2,3,1,2,3],  True)
    , (2, [1,2,3,4],      False)
    , (4, [1..4]++[1..4], True)
    , (3, [],             False)
    ] 4


-- Problem 14: isRepeats'' foldr  (4 pts)
p14 :: Int
p14 =
  testList2 "P14 isRepeats'' " (isRepeats'' :: Int -> [Int] -> Bool)
    [ (2, [1,2,1,2],      True)
    , (3, [1,2,3,1,2,3],  True)
    , (2, [1,2,3,4],      False)
    , (4, [1..4]++[1..4], True)
    , (3, [],             False)
    ] 4


-- Problem 15: repeats  (6 pts)
p15 :: Int
p15 =
  testList "P15 repeats " (repeats :: [Int] -> Maybe [Int])
    [ ([1,2,1,2,1,2,1,2], Just [1,2,1,2])
    , ([1,2,1,2],         Just [1,2])
    , ([1,2,3],           Nothing)
    , ([],                Nothing)
    , ([5,5,5,5],         Just [5,5])
    ] 6
