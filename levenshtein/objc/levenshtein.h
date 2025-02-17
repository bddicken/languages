#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Calculates the Levenshtein distance between two strings using the Wagner-Fischer algorithm.
 *
 * @param s1
 * @param s2
 * @return The Levenshtein distance between s1 and s2.
 */
NSInteger levenshteinDistance(NSString *s1, NSString *s2);

/**
 * Calculates the Levenshtein distances for every pairing of words in the given array.
 *
 * @param words
 * @return A pointer to an array of NSInteger values representing the distances.
 */
NSInteger* distances(NSArray<NSString *> *words);

#ifdef __cplusplus
}
#endif