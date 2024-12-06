BEGIN {

  # Parse command-line argument for u
  u = ARGV[1]
  delete ARGV[1]
  
  # Initialization not necessary, int(result) is zero by default

  # Sum up Fibonacci values for numbers from 1 to u
  for (i=1;i<u;i++) {
    r += fibonacci(i)
  }

  # Print result
  print r

}

# Recursive Fibonacci function
function fibonacci(n) {
  if ( n == 0 ) { return 0 }
  if ( n == 1 ) { return 1 }
  return fibonacci(n - 1) + fibonacci(n - 2)
}
