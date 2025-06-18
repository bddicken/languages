import std.stdio;
import std.algorithm;
import std.array;
import std.range;

/**
 * Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
 * Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
 * Time Complexity: O(m*n) where m and n are the lengths of the input strings
 */
int levenshteinDistance(const(char)[] s1, const(char)[] s2) @safe pure nothrow {
    // Early termination checks
    if (s1 == s2) return 0;
    if (s1.empty) return cast(int)s2.length;
    if (s2.empty) return cast(int)s1.length;

    // Make s1 the shorter string for space optimization
    if (s1.length > s2.length) {
        import std.algorithm.mutation : swap;
        swap(s1, s2);
    }

    immutable m = cast(int)s1.length;
    immutable n = cast(int)s2.length;

    // Use two arrays instead of full matrix for space optimization
    // Use static array if possible for better performance
    static if (__traits(compiles, int[1024])) {
        int[1024] staticPrevRow = void;
        int[1024] staticCurrRow = void;
        int[] prevRow = staticPrevRow[0 .. m + 1];
        int[] currRow = staticCurrRow[0 .. m + 1];
    } else {
        auto prevRow = new int[m + 1];
        auto currRow = new int[m + 1];
    }

    // Initialize first row
    foreach (i; 0 .. m + 1) {
        prevRow[i] = i;
    }

    // Main computation loop
    foreach (j; 1 .. n + 1) {
        currRow[0] = j;

        foreach (i; 1 .. m + 1) {
            immutable cost = (s1[i-1] == s2[j-1]) ? 0 : 1;
            
            // Calculate minimum of three operations
            currRow[i] = min(
                prevRow[i] + 1,      // deletion
                currRow[i-1] + 1,    // insertion
                prevRow[i-1] + cost  // substitution
            );
        }

        // Swap rows
        swap(prevRow, currRow);
    }

    return prevRow[m];
}

void main(string[] args) {
    // Skip program name
    args = args[1 .. $];
    
    if (args.length < 2) {
        writeln("Please provide at least two strings as arguments.");
        return;
    }

    int minDistance = -1;
    int times = 0;

    // Compare all pairs of strings
    foreach (i; 0 .. args.length) {
        foreach (j; 0 .. args.length) {
            if (i != j) {
                immutable distance = levenshteinDistance(args[i], args[j]);
                if (minDistance == -1 || distance < minDistance) {
                    minDistance = distance;
                }
                ++times;
            }
        }
    }

    writefln("times: %d", times);
    writefln("min_distance: %d", minDistance);
}
