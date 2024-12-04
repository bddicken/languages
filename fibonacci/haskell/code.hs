module Main where

import System.Environment (getArgs)

fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)

main :: IO ()
main = do
  args <- getArgs
  case args of
    (x:_) -> do
      let u = subtract 1 (read x)
      print $ sum $ [r | i <- [1 .. u], let r = fibonacci i]
    _ -> putStrLn "Please provide an argument."
