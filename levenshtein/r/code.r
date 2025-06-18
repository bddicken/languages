# Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
# Space Complexity: O(min(m,n)) - only uses two vectors instead of full matrix
# Time Complexity: O(m*n) where m and n are the lengths of the input strings
levenshtein_distance <- function(s1, s2) {
  # Early termination checks
  if (identical(s1, s2)) return(0)
  if (nchar(s1) == 0) return(nchar(s2))
  if (nchar(s2) == 0) return(nchar(s1))
  
  # Make s1 the shorter string for space optimization
  if (nchar(s1) > nchar(s2)) {
    temp <- s1
    s1 <- s2
    s2 <- temp
  }
  
  # Get string lengths
  m <- nchar(s1)
  n <- nchar(s2)
  
  # Convert strings to character vectors for faster access
  s1_chars <- strsplit(s1, "")[[1]]
  s2_chars <- strsplit(s2, "")[[1]]
  
  # Use two vectors instead of full matrix for space optimization
  prev_row <- 0:m
  curr_row <- integer(m + 1)
  
  # Main computation loop - using vectorization where possible
  for (j in 1:n) {
    curr_row[1] <- j
    
    for (i in 1:m) {
      # Calculate cost
      cost <- if (s1_chars[i] == s2_chars[j]) 0L else 1L
      
      # Calculate minimum of three operations
      curr_row[i + 1] <- min(
        prev_row[i + 1] + 1L,    # deletion
        curr_row[i] + 1L,        # insertion
        prev_row[i] + cost       # substitution
      )
    }
    
    # Swap rows
    prev_row <- curr_row
    curr_row <- integer(m + 1)
  }
  
  prev_row[m + 1]
}

# Main program
main <- function() {
  # Get command line arguments
  args <- commandArgs(trailingOnly = TRUE)
  
  if (length(args) < 2) {
    cat("Please provide at least two strings as arguments.\n")
    quit(status = 1)
  }
  
  min_distance <- -1
  times <- 0
  
  # Compare all pairs of strings
  # Using nested sapply for better performance than nested loops
  distances <- sapply(seq_along(args), function(i) {
    sapply(seq_along(args), function(j) {
      if (i != j) {
        distance <- levenshtein_distance(args[i], args[j])
        if (min_distance == -1 || distance < min_distance) {
          min_distance <<- distance
        }
        times <<- times + 1
      }
    })
  })
  
  cat(sprintf("times: %d\n", times))
  cat(sprintf("min_distance: %d\n", min_distance))
}

# Run main program
main()
