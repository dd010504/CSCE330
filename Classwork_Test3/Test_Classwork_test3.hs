module Test_Classwork_test3 where

import Classwork_test3

-- ============================================================
-- Scoring: 6 problems, 50 points total
--   P1 divisors       9 pts  (6 tests)
--   P2 letterGrade    9 pts  (12 tests)
--   P3 third          8 pts  (6 tests)
--   P4 squareEvens    8 pts  (7 tests)
--   P5 product        8 pts  (8 tests)
--   P6 count          8 pts  (8 tests)
-- ============================================================

data Result = Pass String | Fail String String String
  deriving (Eq)

instance Show Result where
  show (Pass name)              = "  PASS  " ++ name
  show (Fail name expected got) = "  FAIL  " ++ name
                                ++ "\n         expected: " ++ expected
                                ++ "\n         got:      " ++ got

check :: (Show a, Eq a) => String -> a -> a -> Result
check name expected actual
  | expected == actual = Pass name
  | otherwise          = Fail name (show expected) (show actual)

-- Returns (points earned, max points) for a suite.
-- Score scales proportionally: floor(passed/total * maxPts),
-- with full marks only when all tests pass.
scoreSuite :: String -> [Result] -> Int -> IO Int
scoreSuite heading results maxPts = do
  putStrLn $ "\n=== " ++ heading ++ " ==="
  mapM_ (putStrLn . show) results
  let passed = length [ r | r@(Pass _) <- results ]
      total  = length results
      pts    = if total == 0 then 0
               else (passed * maxPts) `div` total
  putStrLn $ "  " ++ show passed ++ "/" ++ show total
          ++ " tests  =>  " ++ show pts ++ "/" ++ show maxPts ++ " pts"
  return pts

-- ============================================================
-- Problem 1 — divisors / divisors'   (9 pts)
-- ============================================================

p1Tests :: [Result]
p1Tests =
  [ check "divisors 12"     [1,2,3,4,6,12] (divisors 12)
  , check "divisors 7"      [1,7]           (divisors 7)
  , check "divisors 1"      [1]             (divisors 1)
  , check "divisors' 12"    [1,2,3,4,6,12] (divisors' 12)
  , check "divisors' 7"     [1,7]           (divisors' 7)
  , check "divisors' 1"     [1]             (divisors' 1)
  ]

-- ============================================================
-- Problem 2 — letterGrade / letterGrade'   (9 pts)
-- ============================================================

p2Tests :: [Result]
p2Tests =
  [ check "letterGrade 95"  'A' (letterGrade 95)
  , check "letterGrade 85"  'B' (letterGrade 85)
  , check "letterGrade 72"  'C' (letterGrade 72)
  , check "letterGrade 65"  'D' (letterGrade 65)
  , check "letterGrade 40"  'F' (letterGrade 40)
  , check "letterGrade 90"  'A' (letterGrade 90)   -- boundary
  , check "letterGrade' 95" 'A' (letterGrade' 95)
  , check "letterGrade' 85" 'B' (letterGrade' 85)
  , check "letterGrade' 72" 'C' (letterGrade' 72)
  , check "letterGrade' 65" 'D' (letterGrade' 65)
  , check "letterGrade' 40" 'F' (letterGrade' 40)
  , check "letterGrade' 90" 'A' (letterGrade' 90)  -- boundary
  ]

-- ============================================================
-- Problem 3 — third / third'   (8 pts)
-- ============================================================

p3Tests :: [Result]
p3Tests =
  [ check "third [5,6,7,8]"    (7 :: Int)  (third [5,6,7,8])
  , check "third \"haskell\""  's'          (third "haskell")
  , check "third [1,2,3]"      (3 :: Int)  (third [1,2,3])
  , check "third' [5,6,7,8]"   (7 :: Int)  (third' [5,6,7,8])
  , check "third' \"haskell\"" 's'          (third' "haskell")
  , check "third' [1,2,3]"     (3 :: Int)  (third' [1,2,3])
  ]

-- ============================================================
-- Problem 4 — squareEvens / squareEvens'   (8 pts)
-- ============================================================

p4Tests :: [Result]
p4Tests =
  [ check "squareEvens [1,2,3,4,5]"  [4,16]  (squareEvens [1,2,3,4,5])
  , check "squareEvens [7,8]"         [64]    (squareEvens [7,8])
  , check "squareEvens []"            []      (squareEvens [])
  , check "squareEvens [1,3,5]"       []      (squareEvens [1,3,5])
  , check "squareEvens' [1,2,3,4,5]" [4,16]  (squareEvens' [1,2,3,4,5])
  , check "squareEvens' [7,8]"        [64]    (squareEvens' [7,8])
  , check "squareEvens' []"           []      (squareEvens' [])
  ]

-- ============================================================
-- Problem 5 — product' / product''   (8 pts)
-- ============================================================

p5Tests :: [Result]
p5Tests =
  [ check "product' [2,3,4]"   24  (product' [2,3,4])
  , check "product' []"         1  (product' [])
  , check "product' [5]"        5  (product' [5])
  , check "product' [1,1,1]"    1  (product' [1,1,1])
  , check "product'' [2,3,4]"  24  (product'' [2,3,4])
  , check "product'' []"        1  (product'' [])
  , check "product'' [5]"       5  (product'' [5])
  , check "product'' [1,1,1]"   1  (product'' [1,1,1])
  ]

-- ============================================================
-- Problem 6 — count / count'   (8 pts)
-- ============================================================

p6Tests :: [Result]
p6Tests =
  [ check "count 3 [3,1,3,3,2]"   3 (count 3 [3,1,3,3,2 :: Int])
  , check "count 'a' \"banana\""   3 (count 'a' "banana")
  , check "count 9 [1,2,3]"        0 (count (9 :: Int) [1,2,3])
  , check "count 1 []"             0 (count (1 :: Int) [])
  , check "count' 3 [3,1,3,3,2]"  3 (count' 3 [3,1,3,3,2 :: Int])
  , check "count' 'a' \"banana\""  3 (count' 'a' "banana")
  , check "count' 9 [1,2,3]"       0 (count' (9 :: Int) [1,2,3])
  , check "count' 1 []"            0 (count' (1 :: Int) [])
  ]

-- ============================================================
-- Main
-- ============================================================

main :: IO ()
main = do
  putStrLn "========================================"
  putStrLn "  CSCE 330 Test 3 - Classwork Tests"
  putStrLn "========================================"
  s1 <- scoreSuite "P1  divisors / divisors'"      p1Tests 9
  s2 <- scoreSuite "P2  letterGrade / letterGrade'" p2Tests 9
  s3 <- scoreSuite "P3  third / third'"             p3Tests 8
  s4 <- scoreSuite "P4  squareEvens / squareEvens'" p4Tests 8
  s5 <- scoreSuite "P5  product' / product''"       p5Tests 8
  s6 <- scoreSuite "P6  count / count'"             p6Tests 8
  let total = s1 + s2 + s3 + s4 + s5 + s6
  putStrLn "\n========================================"
  putStrLn $ "  SCORE: " ++ show total ++ " / 50"
  putStrLn "========================================"