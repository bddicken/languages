# Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
# Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
# Time Complexity: O(m*n) where m and n are the lengths of the input strings
def levenshtein_distance(s1, s2)
  # Early termination checks
  return 0 if s1 == s2
  return s2.length if s1.empty?
  return s1.length if s2.empty?

  # Make s1 the shorter string for space optimization
  s1, s2 = s2, s1 if s1.length > s2.length

  m, n = s1.length, s2.length

  # Use two arrays instead of full matrix for space optimization
  prev_row = Array.new(m + 1) { |i| i }
  curr_row = Array.new(m + 1)

  # Convert strings to bytes for faster access
  s1_bytes = s1.bytes.freeze
  s2_bytes = s2.bytes.freeze

  # Main computation loop
  n.times do |j|
    curr_row[0] = j+1

    m.times do |i|
      cost = (s1_bytes[i] == s2_bytes[j]) ? 0 : 1

      # Calculate minimum of three operations
      curr_row[i+1] = [
        prev_row[i+1] + 1,      # deletion
        curr_row[i] + 1,    # insertion
        prev_row[i] + cost  # substitution
      ].min
    end

    # Swap rows
    prev_row, curr_row = curr_row, prev_row
  end

  prev_row[m]
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.length < 2
    puts "Please provide at least two strings as arguments."
    exit 1
  end

  min_distance = -1
  times = 0

  # Compare all pairs of strings
  ARGV.each_with_index do |str1, i|
    ARGV.each_with_index do |str2, j|
      next if i == j
      distance = levenshtein_distance(str1, str2)
      min_distance = distance if min_distance == -1 || distance < min_distance
      times += 1
    end
  end

  puts "times: #{times}"
  puts "min_distance: #{min_distance}"
end
