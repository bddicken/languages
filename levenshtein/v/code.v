fn min(a int, b int, c int) int {
	mut min := a
	if b < min {
		min = b
	}
	if c < min {
		min = c
	}
	return min
}

@[direct_array_access]
fn levenshtein_distance(s1 string, s2 string) int {
	if s1.len == 0 {
		return s2.len
	}
	if s2.len == 0 {
		return s1.len
	}
	if s1 == s2 {
		return 0
	}
	// Assign shorter one to str1, longer one to str2
	str1 := if s1.len <= s2.len { s1 } else { s2 }
	str2 := if s1.len <= s2.len { s2 } else { s1 }
	// store the lengths of shorter in m, longer in n
	m := if str1.str == s1.str { s1.len } else { s2.len }
	n := if str1.str == s1.str { s2.len } else { s1.len }
	// Create two rows, previous and current, initialize the previous row
	mut curr := []int{len: m + 1}
	mut prev := []int{len: m + 1, init: index}
	// Iterate and compute distance
	for i := 1; i <= n; i++ {
		curr[0] = i
		for j := 1; j <= m; j++ {
			cost := if unsafe { str1[j - 1] == str2[i - 1] } { 0 } else { 1 }
			curr[j] = min(prev[j] + 1, // Deletion
			 curr[j - 1] + 1, // Insertion
			 prev[j - 1] + cost // Substitution
			 )
		}
		unsafe { vmemcpy(prev.data, curr.data, 4 * prev.len) }
	}
	// Return final distance, stored in prev[m]
	return prev[m]
}

@[direct_array_access]
fn main() {
	args := arguments()
	mut min_distance := -1
	mut times := 0
	// Iterate through all combinations of command line args
	for i := 1; i < args.len; i++ {
		for j := 1; j < args.len; j++ {
			// Don't compare the same string to itself
			if i != j {
				distance := levenshtein_distance(args[i], args[j])
				if min_distance == -1 || min_distance > distance {
					min_distance = distance
				}
				times++
			}
		}
	}

	// The only output from the program should be the times (number of comparisons)
	// and min distance calculated of all comparisons. Two total lines of output,
	// formatted exactly like this.
	println('times: ${times}')
	println('min_distance: ${min_distance}')
}
