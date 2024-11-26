# Recursive Fibonacci function
fibonacciAcc <- function(n,a,b) {
  if (n == 0) return(a)
  return(fibonacciAcc(n - 1, b, a + b))
}
fibonacci <- function(n) {
  return (fibonacciAcc(n,0,1))
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
