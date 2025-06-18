import System.Environment (getArgs)
import Data.Vector.Unboxed as V (Vector, (!), generate, length, fromList, toList)
import qualified Data.Vector.Unboxed.Mutable as MV
import Control.Monad (forM_)
import Data.List (minimumBy)
import Data.Ord (comparing)

-- | Calculates Levenshtein distance between two strings using Wagner-Fischer algorithm
-- Space Complexity: O(min(m,n)) - only uses two vectors instead of full matrix
-- Time Complexity: O(m*n) where m and n are the lengths of the input strings
levenshteinDistance :: String -> String -> Int
levenshteinDistance s1 s2
    | s1 == s2 = 0
    | null s1 = length s2
    | null s2 = length s1
    | length s1 > length s2 = levenshteinDistance s2 s1  -- Make s1 the shorter string
    | otherwise = go s1 s2
  where
    go str1 str2 = V.last $ foldl processRow initialRow [1..n]
      where
        m = length str1
        n = length str2
        
        -- Initialize first row
        initialRow = V.generate (m + 1) id
        
        -- Process each row of the matrix
        processRow prevRow j = V.create $ do
            currRow <- MV.new (m + 1)
            MV.write currRow 0 j
            
            forM_ [1..m] $ \i -> do
                let cost = if str1 !! (i-1) == str2 !! (j-1) then 0 else 1
                let deletion = prevRow ! i + 1
                let insertion = (currRow ! (i-1)) + 1
                let substitution = prevRow ! (i-1) + cost
                MV.write currRow i (minimum [deletion, insertion, substitution])
            
            return currRow

main :: IO ()
main = do
    args <- getArgs
    if length args < 2
        then putStrLn "Please provide at least two strings as arguments."
        else do
            let pairs = [(i, j) | i <- [0..length args - 1], j <- [0..length args - 1], i /= j]
            let distances = [levenshteinDistance (args !! i) (args !! j) | (i, j) <- pairs]
            let minDist = minimum distances
            putStrLn $ "times: " ++ show (length pairs)
            putStrLn $ "min_distance: " ++ show minDist
