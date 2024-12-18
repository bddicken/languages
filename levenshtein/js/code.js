/**
 * Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm.
 * Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
 * Time Complexity: O(m*n) where m and n are the lengths of the input strings
 * 
 * @param {string} str1 First string to compare
 * @param {string} str2 Second string to compare
 * @returns {number} The Levenshtein distance between str1 and str2
 */
function levenshteinDistance(str1, str2) {
  // Input validation
  if (typeof str1 !== 'string' || typeof str2 !== 'string') {
      throw new TypeError('Both arguments must be strings');
  }

  // Early termination checks
  if (str1 === str2) return 0;
  if (!str1.length) return str2.length;
  if (!str2.length) return str1.length;

  // Make str1 the shorter string for space optimization
  if (str1.length > str2.length) {
      [str1, str2] = [str2, str1];
  }

  const m = str1.length;
  const n = str2.length;

  // Use TypedArrays for better performance
  let prevRow = new Uint32Array(m + 1);
  let currRow = new Uint32Array(m + 1);

  // Initialize the first row
  for (let i = 0; i <= m; i++) {
      prevRow[i] = i;
  }

  // Main computation loop
  for (let j = 1; j <= n; j++) {
      currRow[0] = j;

      for (let i = 1; i <= m; i++) {
          const cost = str1[i - 1] === str2[j - 1] ? 0 : 1;
          currRow[i] = Math.min(
              prevRow[i] + 1,      // deletion
              currRow[i - 1] + 1,  // insertion
              prevRow[i - 1] + cost // substitution
          );
      }

      // Swap rows
      [prevRow, currRow] = [currRow, prevRow];
  }

  return prevRow[m];
}

/**
* Main function to find minimum Levenshtein distance between any pair of input strings
* @param {string[]} args Array of strings to compare
* @returns {number} Exit code (0 for success)
*/
function main(args) {
  if (!args.length) {
      return 1;
  }

  let minDistance = -1;  // Changed back to -1 to match spec
  let times = 0;        // Changed back to 'times' to match spec

  // Compare all pairs of strings
  for (let i = 0; i < args.length; i++) {
      for (let j = 0; j < args.length; j++) {
          if (i !== j) {
              const distance = levenshteinDistance(args[i], args[j]);
              if (minDistance === -1 || minDistance > distance) {
                  minDistance = distance;
              }
              times++;
          }
      }
  }

  // Match exact output format from spec
  console.log(`times: ${times}`);
  console.log(`min_distance: ${minDistance}`);
  return 0;
}

// Handle command-line arguments for Node.js
if (typeof process !== 'undefined' && process.argv) {
  process.exit(main(process.argv.slice(2)));
}
