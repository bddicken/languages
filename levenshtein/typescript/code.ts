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
function levenshteinDistance(s1: string, s2: string): number {
    // Early termination checks
    if (s1 === s2) return 0;
    if (s1.length === 0) return s2.length;
    if (s2.length === 0) return s1.length;
    
    // Make s1 the shorter string for space optimization
    if (s1.length > s2.length) {
        [s1, s2] = [s2, s1];
    }
    
    const m: number = s1.length;
    const n: number = s2.length;
    
    // Use typed arrays for better performance
    const prevRow = new Uint32Array(m + 1);
    const currRow = new Uint32Array(m + 1);
    
    // Initialize first row
    for (let i = 0; i <= m; i++) {
        prevRow[i] = i;
    }
    
    // Main computation loop
    for (let j = 1; j <= n; j++) {
        currRow[0] = j;
        
        for (let i = 1; i <= m; i++) {
            const cost = s1[i - 1] === s2[j - 1] ? 0 : 1;
            
            // Calculate minimum of three operations
            const deletion = prevRow[i] + 1;
            const insertion = currRow[i - 1] + 1;
            const substitution = prevRow[i - 1] + cost;
            
            currRow[i] = Math.min(deletion, Math.min(insertion, substitution));
        }
        
        // Swap rows using typed array copy
        prevRow.set(currRow);
    }
    
    return prevRow[m];
}

// Main program
function main(): void {
    const args = process.argv.slice(2);
    
    if (args.length < 2) {
        console.log("Please provide at least two strings as arguments.");
        process.exit(1);
    }
    
    let minDistance = -1;
    let times = 0;
    
    // Compare all pairs of strings
    for (let i = 0; i < args.length; i++) {
        for (let j = 0; j < args.length; j++) {
            if (i !== j) {
                const distance = levenshteinDistance(args[i], args[j]);
                if (minDistance === -1 || distance < minDistance) {
                    minDistance = distance;
                }
                times++;
            }
        }
    }
    
    console.log(`times: ${times}`);
    console.log(`min_distance: ${minDistance}`);
}

// Run the program
main();
