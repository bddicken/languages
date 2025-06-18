def levenshtein(strings : Array(String)) : Array(Int32)
	strings.each_combination(2, reuse: true).map { |pair|
		levenshtein_distance(pair[0], pair[1])
	}.to_a
end

def levenshtein_distance(s1 : String, s2 : String) : Int32
	# Early termination checks
	return s2.size if s1.empty?
	return s1.size if s2.empty?

	# Make s1 the shorter string for space optimization
	s1, s2 = s2, s1 if s1.size > s2.size

	m = s1.size
	n = s2.size

	# Use two arrays instead of full matrix for space optimization
	prev_row = Array.new(m+1) {|i| i}
	curr_row = Array.new(m+1, 0)


	# Convert strings to bytes for faster access
	s1_bytes = s1.to_slice
	s2_bytes = s2.to_slice

	s2_bytes.each_with_index do |ch1, i|
		curr_row[0] = i &+ 1

		s1_bytes.each_with_index do |ch2, j|
		  cost = ch2 == ch1 ? 0 : 1

		  # Calculate minimum of three operations
		  curr_row[j &+ 1] = {
			 prev_row[j &+ 1] &+ 1,  # deletion
			 curr_row[j] &+ 1,       # insertion
			 prev_row[j] &+ cost     # substitution
		  }.min
		end

		prev_row, curr_row = curr_row, prev_row
	 end

	prev_row[m]
 end