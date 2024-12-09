# Get input number from the command line arguments
args <- commandArgs(trailingOnly = TRUE)
u <- as.integer(args[1])  # Convert to integer

# Generate a random number between 0 and 10000
r <- sample(0:9999, 1)

# Initialize an array of 10k elements to 0
a <- rep(0, 10000)
# avoid recreating sequence 
seq_2 <- seq_len(100000) - 1
# Perform the nested loop operation
for (i in seq_len(10000)) {          # Outer loop: 10k iterations
  num <- 0 
  for (j in seq_2) {  # Inner loop: 100k iterations
    num <- num + (j %% u)         # Simple sum
  }
  a[i] <- num + r                  # Add the random value to each element
}

# Print a single element from the array
print(a[r + 1])  # Adjusted for R's 1-based indexing
