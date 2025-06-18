package jvm;

import java.util.ArrayList;
import java.util.List;

/**
 * This class implements the Levenshtein distance algorithm and provides
 * functionality
 * to benchmark it and provide output with benchmark results + for correctness
 * check.
 */
public class levenshtein {
    /**
     * Calculates the Levenshtein distance between two strings using an optimized
     * version of Wagner-Fischer algorithm that uses O(min(m,n)) space.
     *
     * @param s1 The first string to compare
     * @param s2 The second string to compare
     * @return The Levenshtein distance between s1 and s2
     */
    private static long levenshteinDistance(String s1, String s2) {
        // Optimize by ensuring s1 is the shorter string to minimize space usage
        if (s1.length() > s2.length()) {
            String temp = s1;
            s1 = s2;
            s2 = temp;
        }

        int m = s1.length();
        int n = s2.length();

        // Only need two rows for the dynamic programming matrix
        long[] prev = new long[m + 1];
        long[] curr = new long[m + 1];

        // Initialize the first row
        for (int j = 0; j <= m; j++) {
            prev[j] = j;
        }

        // Fill the matrix row by row
        for (int i = 1; i <= n; i++) {
            curr[0] = i;
            for (int j = 1; j <= m; j++) {
                // Calculate cost - 0 if characters are same, 1 if different
                long cost = (s1.charAt(j - 1) == s2.charAt(i - 1)) ? 0 : 1;

                // Calculate minimum of deletion, insertion, and substitution
                curr[j] = Math.min(
                        Math.min(prev[j] + 1, // deletion
                                curr[j - 1] + 1), // insertion
                        prev[j - 1] + cost); // substitution
            }

            // Swap rows
            long[] temp = prev;
            prev = curr;
            curr = temp;
        }

        return prev[m];
    }

    /**
     * @return A list of Levenshtein distances for all pairings of the input strings
     * @param strings
     */
    public static List<Long> distances(List<String> strings) {
        List<Long> distances = new ArrayList<>();
        // Compare all pairs and store their distances
        for (int i = 0; i < strings.size(); i++) {
            for (int j = i + 1; j < strings.size(); j++) {
                distances.add(levenshteinDistance(strings.get(i), strings.get(j)));
            }
        }
        return distances;
    }
}

