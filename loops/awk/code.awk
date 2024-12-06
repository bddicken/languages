BEGIN {
  
  # Get input number from the command line arguments 
  u = ARGV[1]
  delete ARGV[1]

  # Generate a random number 0 <= r < 10k
  r = int( rand() * 10000 )

  # Array initialization not necessary, all elements are 0 by default

  # Iterations: 10k outer loop, 100k inner loop
  for (i=0;i<10000;i++) {
    for (j=0;j<100000;j++) {
      a[i] += j % u             # simple sum
      }
    a[i] += r                   # add random value
    }

  # Print out a single element from the array
  print a[r]

}
