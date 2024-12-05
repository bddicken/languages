# Get input number from the command line arguments
args <- commandArgs(trailingOnly = TRUE)
u <- as.integer(args[1])  # Convert to integer

# Generate a random number between 0 and 9999
r <-  sample.int(10000, 1) - 1L

# Vectored version of loop
a <- rep(sum((seq_len(100000) - 1L) %% u), 10000) + r

# Print a single element from the array
print(a[r + 1])  # Adjusted for R's 1-based indexing
