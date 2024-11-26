# enforce precompile
Base.@ccallable function julia_main()::Cint
  u = parse(Int, ARGS[1])                     # Get an input number from command line
  r = rand(1:10000)                           # Get a random number 1 <= r <= 10k
  a = zeros(Int, 10000)                       # Array of 10k elements initialized to 0

  for i in 1:10000                            # 10k outer loop iterations
      for j in 0:99999                        # 100k inner loop iterations, per outer loop
          a[i] += j % u                       # Simple sum
      end
      a[i] += r                               # Add a random value to each element in array
  end

  println(a[r])                               # Print out a single element from the array
  return 0
end

# Call the main function
if abspath(PROGRAM_FILE) == @__FILE__
  julia_main()
end