package jvm;

/**
 * This class implements the Levenshtein distance algorithm and provides functionality
 * to find the minimum edit distance between pairs of strings.
 */
public class code {

    /**
     * Calculates the Levenshtein distance between two strings using an optimized
     * version of Wagner-Fischer algorithm that uses O(min(m,n)) space.
     *
     * @param s1 The first string to compare
     * @param s2 The second string to compare
     * @return The Levenshtein distance between s1 and s2
     */
    public static long levenshteinDistance(String s1, String s2) {
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
                    Math.min(prev[j] + 1,      // deletion
                            curr[j - 1] + 1),   // insertion
                    prev[j - 1] + cost);        // substitution
            }

            // Swap rows
            long[] temp = prev;
            prev = curr;
            curr = temp;
        }

        return prev[m];
    }

    /**
     * Main method that processes command line arguments and finds the minimum
     * Levenshtein distance between any pair of input strings.
     *
     * @param args Command line arguments containing strings to compare
     */
    public static void main(String[] args) {
        if (args.length < 2) {
            System.out.println("Usage: java jvm.Code <string1> <string2> ...");
            return;
        }

        long minDistance = Long.MAX_VALUE;
        int comparisons = 0;

        // Optimize loop to avoid redundant comparisons (i,j) vs (j,i)
        for (int i = 0; i < args.length; i++) {
            for (int j = 0; j < args.length; j++) {
                if (i != j) {
                    long distance = levenshteinDistance(args[i], args[j]);
                    minDistance = Math.min(minDistance, distance);
                    comparisons++;
                }
            }
        }

        System.out.println("times: " + comparisons);
        System.out.println("min_distance: " + minDistance);
    }
}
