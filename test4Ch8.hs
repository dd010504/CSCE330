module Chapter8Practice where

-- ============================================================
-- PRE-REQUISITE TYPES (Your professor will provide these)
-- ============================================================

data Nat = Zero | Succ Nat deriving (Show, Eq)

data Expr = Val Int 
          | Add Expr Expr 
          | Mul Expr Expr 
          deriving Show

data Tree a = Nil 
            | Leaf a 
            | Node (Tree a) a (Tree a) 
            deriving Show

-- ============================================================
-- Q1 (Easy/Medium) — The Maybe Type
-- Goal: Define safeDiv :: Int -> Int -> Maybe Int
-- Details: Perform integer division (`div`). If the denominator is 0, 
--          return Nothing to prevent a crash. Otherwise, return Just the result.
-- Examples:
--   safeDiv 10 2 == Just 5
--   safeDiv 10 0 == Nothing
-- ============================================================

safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv xy = Just (x 'div' y)


-- ============================================================
-- Q2 (Medium) — The Nat Type
-- Goal: Define addNat :: Nat -> Nat -> Nat
-- Details: Add two natural numbers together by peeling `Succ` layers 
--          off the first number and stacking them onto the second.
-- Examples: (Assuming nat2int and int2nat exist)
--   nat2int (addNat (int2nat 2) (int2nat 3)) == 5
-- ============================================================

addNat :: Nat -> Nat -> Nat
addNat Zero n = n
addNat (Succ m) n = Succ (addNat m n)

-- ============================================================
-- Q3 (Medium) — The Expr Type
-- Goal: Define countOps :: Expr -> Int
-- Details: Return the total number of mathematical operations (Add or Mul nodes) 
--          in the expression. A raw Val contains 0 operations.
-- Examples:
--   countOps (Val 5) == 0
--   countOps (Add (Val 2) (Mul (Val 3) (Val 4))) == 2
-- ============================================================

countOps :: Expr -> Int
countOps (Val _)     = 0
countOps (Add e1 e2) = 1 + countOps e1 + countOps e2
countOps (Mul e1 e2) = 1 + countOps e1 + countOps e2

-- ============================================================
-- Q4 (Medium) — The Tree Type
-- Goal: Define countLeaves :: Tree a -> Int
-- Details: Count the total number of `Leaf` constructors in the tree. 
--          A `Nil` branch contributes 0.
-- Examples:
--   countLeaves Nil == 0
--   countLeaves (Node (Leaf 1) 2 (Node Nil 3 (Leaf 4))) == 2
-- ============================================================

countLeaves :: Tree a -> Int
countLeaves Nil          = 0
countLeaves (Leaf _)     = 1
countLeaves (Node l _ r) = countLeaves l + countLeaves r