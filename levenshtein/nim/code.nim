import os

proc levenshteinDistance*(s1, s2: string): int =
  ## Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
  ## Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
  ## Time Complexity: O(m*n) where m and n are the lengths of the input strings
  
  # Early termination checks
  if s1 == s2: return 0
  if s1.len == 0: return s2.len
  if s2.len == 0: return s1.len

  # Make s1 the shorter string for space optimization
  var 
    str1 = if s1.len > s2.len: s2 else: s1
    str2 = if s1.len > s2.len: s1 else: s2

  let 
    m = str1.len
    n = str2.len

  # Use two arrays instead of full matrix for space optimization
  var
    prevRow = newSeq[int](m + 1)
    currRow = newSeq[int](m + 1)

  # Initialize first row
  for i in 0..m:
    prevRow[i] = i

  # Main computation loop
  for j in 1..n:
    currRow[0] = j

    for i in 1..m:
      let cost = if str1[i-1] == str2[j-1]: 0 else: 1
      
      # Calculate minimum of three operations using templates for performance
      template deletion: int = prevRow[i] + 1
      template insertion: int = currRow[i-1] + 1
      template substitution: int = prevRow[i-1] + cost
      
      currRow[i] = min([deletion(), insertion(), substitution()])

    # Swap rows using move semantics
    swap(prevRow, currRow)

  result = prevRow[m]

when isMainModule:
  # Get command line arguments
  let args = commandLineParams()
  
  if args.len < 2:
    echo "Please provide at least two strings as arguments."
    quit(1)

  var
    minDistance = -1
    times = 0

  # Compare all pairs of strings
  for i in 0..<args.len:
    for j in 0..<args.len:
      if i != j:
        let distance = levenshteinDistance(args[i], args[j])
        if minDistance == -1 or distance < minDistance:
          minDistance = distance
        inc times

  echo "times: ", times
  echo "min_distance: ", minDistance
