# Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
# Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
# Time Complexity: O(m*n) where m and n are the lengths of the input strings
def levenshtein_distance(s1 : String, s2 : String) : Int32
  # Early termination checks
  return 0 if s1 == s2
  return s2.size if s1.empty?
  return s1.size if s2.empty?

  # Make s1 the shorter string for space optimization
  s1, s2 = s2, s1 if s1.size > s2.size

  m = s1.size
  n = s2.size

  # Use two arrays instead of full matrix for space optimization
  prev_row = StaticArray(Int32, 1024).new {|i| i}
  curr_row = StaticArray(Int32, 1024).new(0)


  # Convert strings to bytes for faster access
  s1_bytes = s1.to_slice
  s2_bytes = s2.to_slice

  # Main computation loop
  (1..n).each do |i|
    curr_row[0] = i

    (1..m).each do |j|
      cost = s1_bytes[j &- 1] == s2_bytes[i &- 1] ? 0 : 1
      
      # Calculate minimum of three operations
      curr_row[j] = {
        prev_row[j] &+ 1,      # deletion
        curr_row[j &- 1] &+ 1,  # insertion
        prev_row[j &- 1] &+ cost # substitution
		}.min
    end

    # Swap rows
    prev_row = curr_row
  end

  prev_row[m]
end

# Main program
if ARGV.size < 2
  puts "Please provide at least two strings as arguments."
  exit 1
end

min_distance = -1
times = 0

# Compare all permutations of strings
ARGV.each_permutation(2) do |pair|
	distance = levenshtein_distance(pair[0], pair[1])
	min_distance = distance if distance < min_distance || min_distance == -1
	times += 1
end

puts "times: #{times}"
puts "min_distance: #{min_distance}"