import Init.System.IO
import Init.Data.Array.Basic
import Init.Data.String.Basic

/-- Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
    Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
    Time Complexity: O(m*n) where m and n are the lengths of the input strings -/
def levenshteinDistance (s1 s2 : String) : IO Nat := do
  -- Early termination checks
  if s1 == s2 then
    return 0
  if s1.length == 0 then
    return s2.length
  if s2.length == 0 then
    return s1.length

  -- Make s1 the shorter string for space optimization
  let (s1, s2) := if s1.length > s2.length then (s2, s1) else (s1, s2)
  let m := s1.length
  let n := s2.length

  -- Use two arrays instead of full matrix for space optimization
  let mut prevRow <- Array.mkArray (m + 1) 0
  let mut currRow <- Array.mkArray (m + 1) 0

  -- Initialize first row
  for i in [:m + 1] do
    prevRow := prevRow.set! i i

  -- Main computation loop
  for j in [:n] do
    currRow := currRow.set! 0 (j + 1)
    
    for i in [:m] do
      let cost := if s1[i]! == s2[j]! then 0 else 1
      
      -- Calculate minimum of three operations
      let deletion := prevRow[i + 1]! + 1
      let insertion := currRow[i]! + 1
      let substitution := prevRow[i]! + cost
      
      currRow := currRow.set! (i + 1) (min deletion (min insertion substitution))
    
    -- Swap rows
    prevRow := currRow.copy

  return prevRow[m]!

/-- Main program -/
def main (args : List String) : IO Unit := do
  if args.length < 2 then
    IO.println "Please provide at least two strings as arguments."
    IO.Process.exit 1
  
  let mut minDistance := -1
  let mut times := 0
  
  -- Compare all pairs of strings
  for i in [:args.length] do
    for j in [:args.length] do
      if i != j then
        let distance <- levenshteinDistance args[i]! args[j]!
        if minDistance == -1 || distance < minDistance then
          minDistance := distance
        times := times + 1
  
  IO.println s!"times: {times}"
  IO.println s!"min_distance: {minDistance}"
