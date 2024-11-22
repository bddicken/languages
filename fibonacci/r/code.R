# Recursive Fibonacci function
fibonacci <- function(n) {
  if (n == 0) return(0)
  if (n == 1) return(1)
  return(fibonacci(n - 1) + fibonacci(n - 2))
}

# Parse command-line argument for `u`
args <- commandArgs(trailingOnly = TRUE)
u <- as.numeric(args[1])

# Initialize result
r <- 0

# Sum up Fibonacci values for numbers from 1 to `u`
for (i in 1:(u - 1)) {
  r <- r + fibonacci(i)
}

# Print the result
cat(r, "\n")
