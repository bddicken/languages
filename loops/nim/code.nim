import std/[
  cmdline,
  random,
  strutils]


proc main() =
  randomize()
  let u = uint32 parseUInt(paramStr(1))   # Get an input number from the command line
  let r = uint32 random.rand(10000)       # Get a random number 0 <= r < 10k
  var arr  = arrayWith(0.uint32, 10000)   # Array of 10k elements initialized to 0
  for i in 0..(arr.len - 1):             # 10k outer loop iterations
    for j in 0..99999.uint32:             # 100k inner loop iterations, per outer loop iteration
      arr[i] +=  j mod u                  # Simple sum
    arr[i] += r                   # Add a random value to each element in array
  echo $arr[r]                            # Print out a single element from the array

main()
