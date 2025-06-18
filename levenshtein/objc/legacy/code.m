#import <Foundation/Foundation.h>

/**
 * Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
 * Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
 * Time Complexity: O(m*n) where m and n are the lengths of the input strings
 */
NSInteger levenshteinDistance(NSString *s1, NSString *s2) {
    // Early termination checks
    if ([s1 isEqualToString:s2]) return 0;
    if (s1.length == 0) return s2.length;
    if (s2.length == 0) return s1.length;
    
    // Make s1 the shorter string for space optimization
    if (s1.length > s2.length) {
        NSString *temp = s1;
        s1 = s2;
        s2 = temp;
    }
    
    NSUInteger m = s1.length;
    NSUInteger n = s2.length;
    
    // Use two arrays instead of full matrix for space optimization
    NSMutableData *prevRowData = [NSMutableData dataWithLength:(m + 1) * sizeof(NSInteger)];
    NSMutableData *currRowData = [NSMutableData dataWithLength:(m + 1) * sizeof(NSInteger)];
    
    NSInteger *prevRow = (NSInteger *)prevRowData.mutableBytes;
    NSInteger *currRow = (NSInteger *)currRowData.mutableBytes;
    
    // Initialize first row
    for (NSUInteger i = 0; i <= m; i++) {
        prevRow[i] = (NSInteger)i;
    }
    
    // Convert strings to UTF-16 for faster access
    const unichar *s1Chars = CFStringGetCharactersPtr((__bridge CFStringRef)s1);
    const unichar *s2Chars = CFStringGetCharactersPtr((__bridge CFStringRef)s2);
    
    NSMutableData *s1Buffer = nil;
    NSMutableData *s2Buffer = nil;
    
    // If direct access failed, create buffers
    if (s1Chars == NULL) {
        s1Buffer = [NSMutableData dataWithLength:m * sizeof(unichar)];
        s1Chars = s1Buffer.mutableBytes;
        [s1 getCharacters:(unichar *)s1Chars range:NSMakeRange(0, m)];
    }
    if (s2Chars == NULL) {
        s2Buffer = [NSMutableData dataWithLength:n * sizeof(unichar)];
        s2Chars = s2Buffer.mutableBytes;
        [s2 getCharacters:(unichar *)s2Chars range:NSMakeRange(0, n)];
    }
    
    // Main computation loop
    for (NSUInteger j = 1; j <= n; j++) {
        currRow[0] = (NSInteger)j;
        
        for (NSUInteger i = 1; i <= m; i++) {
            NSInteger cost = (s1Chars[i-1] == s2Chars[j-1]) ? 0 : 1;
            
            // Calculate minimum of three operations
            NSInteger deletion = prevRow[i] + 1;
            NSInteger insertion = currRow[i-1] + 1;
            NSInteger substitution = prevRow[i-1] + cost;
            
            currRow[i] = MIN(deletion, MIN(insertion, substitution));
        }
        
        // Swap rows
        NSInteger *temp = prevRow;
        prevRow = currRow;
        currRow = temp;
    }
    
    return prevRow[m];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc < 3) {
            printf("Please provide at least two strings as arguments.\n");
            return 1;
        }
        
        NSInteger minDistance = -1;
        NSInteger times = 0;
        
        // Convert arguments to NSString array
        NSMutableArray<NSString *> *args = [NSMutableArray arrayWithCapacity:(argc - 1)];
        for (int i = 1; i < argc; i++) {
            [args addObject:[NSString stringWithUTF8String:argv[i]]];
        }
        
        // Compare all pairs of strings
        for (NSUInteger i = 0; i < args.count; i++) {
            for (NSUInteger j = 0; j < args.count; j++) {
                if (i != j) {
                    NSInteger distance = levenshteinDistance(args[i], args[j]);
                    if (minDistance == -1 || distance < minDistance) {
                        minDistance = distance;
                    }
                    times++;
                }
            }
        }
        
        printf("times: %ld\n", (long)times);
        printf("min_distance: %ld\n", (long)minDistance);
    }
    return 0;
}
