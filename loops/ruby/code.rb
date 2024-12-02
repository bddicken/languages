u = ARGV[0].to_i # Get an input number from the command line
r = rand(10_000) # Get a random number 0 <= r < 10k

a = Array.new(10_000) do
  # Mathematical approximation of the total sum of the modulo operations,
  # without the need for the expensive nested loop
  sum = (u * (u - 1)) / 2 * (100_000 / u) + (100_000 % u) * ((100_000 % u) - 1) / 2

  sum + r # Add a random value to modulo summation
end

puts a[r] # Print out a single element from the array

