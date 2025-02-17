#import <Foundation/Foundation.h>

int loops(int n) {
    int r = arc4random() % 10000;                                // Get a random integer 0 <= r < 10k

    int32_t a[10000] = {0};                                      // Array of 10k elements initialized to 0
    for (int i = 0; i < 10000; i++) {                            // 10k outer loop iterations
        for (int j = 0; j < 10000; j++) {                        // 10k inner loop iterations, per outer loop iteration
            a[i] = a[i] + j % n;                                 // Simple sum
        }
        a[i] += r;                                               // Add a random value to each element in array
    }
    return  a[r];                                                // Return a single element from the array
}
