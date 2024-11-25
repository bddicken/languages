module Main where

import System.Environment (getArgs)

fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)

main :: IO ()
main = do
  u <- fmap (subtract 1 . read . head) getArgs
  print $ sum $ [r | i <- [1 .. u], let r = fibonacci i]
