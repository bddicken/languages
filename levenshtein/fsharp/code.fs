open System

/// Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
/// Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
/// Time Complexity: O(m*n) where m and n are the lengths of the input strings
let levenshteinDistance (s1: string) (s2: string) =
    // Early termination checks
    if obj.ReferenceEquals(s1, s2) then 0
    elif String.IsNullOrEmpty s1 then s2.Length
    elif String.IsNullOrEmpty s2 then s1.Length
    else
        // Make s1 the shorter string for space optimization
        let s1, s2 = 
            if s1.Length > s2.Length 
            then s2, s1 
            else s1, s2
            
        let m = s1.Length
        let n = s2.Length
        
        // Convert strings to char arrays for faster access
        let s1Chars = s1.ToCharArray()
        let s2Chars = s2.ToCharArray()
        
        // Use two arrays instead of full matrix for space optimization
        let prevRow = Array.init (m + 1) id
        let currRow = Array.zeroCreate (m + 1)
        
        // Main computation loop
        for j = 1 to n do
            currRow.[0] <- j
            
            for i = 1 to m do
                let cost = if s1Chars.[i-1] = s2Chars.[j-1] then 0 else 1
                
                // Calculate minimum of three operations
                currRow.[i] <- min (min 
                    (prevRow.[i] + 1)        // deletion
                    (currRow.[i-1] + 1))     // insertion
                    (prevRow.[i-1] + cost)   // substitution
            
            // Swap rows using array copy for performance
            Array.Copy(currRow, prevRow, m + 1)
        
        prevRow.[m]

[<EntryPoint>]
let main argv =
    if argv.Length < 2 then
        printfn "Please provide at least two strings as arguments."
        1
    else
        let mutable minDistance = -1
        let mutable times = 0
        
        // Compare all pairs of strings
        for i = 0 to argv.Length - 1 do
            for j = 0 to argv.Length - 1 do
                if i <> j then
                    let distance = levenshteinDistance argv.[i] argv.[j]
                    if minDistance = -1 || distance < minDistance then
                        minDistance <- distance
                    times <- times + 1
        
        printfn "times: %d" times
        printfn "min_distance: %d" minDistance
        0
