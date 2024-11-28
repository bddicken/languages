# Updated Function with Pre-alloted vector
fibonacci <- function(n) {
    fib <- vector("integer", n)
    if (n < 2) {
        return(n)
    }
    fib[1:2] <- c(1, 2)
    for (k in 3:n) {
        fib[k] <- fib[k - 1] + fib[k - 2]
    }
    return(fib)
}
# Parse command-line argument for `u`
args <- commandArgs(trailingOnly = TRUE)
u <- as.integer(args[1])

# Sum all fibonacci numbers up to `u`
r <- sum(fibonacci(u))

# Print the result
cat(r, "\n")
