/**
 * Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
 * Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
 * Time Complexity: O(m*n) where m and n are the lengths of the input strings
 *
 * npm install
 * npm run build
 * npm start -- "string1" "string2" "string3"
 *
 */
function levenshteinDistance(s1, s2) {
    var _a;
    // Early termination checks
    if (s1 === s2)
        return 0;
    if (s1.length === 0)
        return s2.length;
    if (s2.length === 0)
        return s1.length;
    // Make s1 the shorter string for space optimization
    if (s1.length > s2.length) {
        _a = [s2, s1], s1 = _a[0], s2 = _a[1];
    }
    var m = s1.length;
    var n = s2.length;
    // Use typed arrays for better performance
    var prevRow = new Uint32Array(m + 1);
    var currRow = new Uint32Array(m + 1);
    // Initialize first row
    for (var i = 0; i <= m; i++) {
        prevRow[i] = i;
    }
    // Main computation loop
    for (var j = 1; j <= n; j++) {
        currRow[0] = j;
        for (var i = 1; i <= m; i++) {
            var cost = s1[i - 1] === s2[j - 1] ? 0 : 1;
            // Calculate minimum of three operations
            var deletion = prevRow[i] + 1;
            var insertion = currRow[i - 1] + 1;
            var substitution = prevRow[i - 1] + cost;
            currRow[i] = Math.min(deletion, Math.min(insertion, substitution));
        }
        // Swap rows using typed array copy
        prevRow.set(currRow);
    }
    return prevRow[m];
}
// Main program
function main() {
    var args = process.argv.slice(2);
    if (args.length < 2) {
        console.log("Please provide at least two strings as arguments.");
        process.exit(1);
    }
    var minDistance = -1;
    var times = 0;
    // Compare all pairs of strings
    for (var i = 0; i < args.length; i++) {
        for (var j = 0; j < args.length; j++) {
            if (i !== j) {
                var distance = levenshteinDistance(args[i], args[j]);
                if (minDistance === -1 || distance < minDistance) {
                    minDistance = distance;
                }
                times++;
            }
        }
    }
    console.log("times: ".concat(times));
    console.log("min_distance: ".concat(minDistance));
}
// Run the program
main();
