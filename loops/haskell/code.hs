module Main where

import System.Environment (getArgs)
import System.Random (randomRIO)
import Data.Maybe (listToMaybe)

main :: IO ()
main = do
  args <- getArgs
  let u = fmap (subtract 1 . read) (listToMaybe args)
  case u of
    Just n -> do
      r <- randomRIO (0, 10000) :: IO Int
      let a =
            [ e
              | let e = sum ([t | t1 <- [1 .. 100000], let t = mod t1 n]) + r,
                _ <- [1 .. 10000]
            ]
      print $ a !! r
    Nothing -> putStrLn "No arguments provided"