#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Convert the first command-line argument to an integer
        int u = [[NSString stringWithUTF8String:argv[1]] intValue];
        int r = arc4random() % 10000;

        // Create a CFMutableArrayRef with initial capacity
        CFMutableArrayRef a = CFArrayCreateMutable(kCFAllocatorDefault, 10000, &kCFTypeArrayCallBacks);

        // Fill the array with initial zeros
        for (int i = 0; i < 10000; i++) {
            CFNumberRef zero = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &(int){0});
            CFArraySetValueAtIndex(a, i, zero);
            CFRelease(zero);
        }

        // Perform calculations
        for (int i = 0; i < 10000; i++) {
            // Get the current value
            CFNumberRef currentNum = CFArrayGetValueAtIndex(a, i);
            int currentValue = 0;
            CFNumberGetValue(currentNum, kCFNumberIntType, &currentValue);

            // Perform calculations
            for (int j = 0; j < 100000; j++) {
                currentValue += j % u;
            }
            currentValue += r;

            // Create and set new number
            CFNumberRef newNum = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &currentValue);
            CFArraySetValueAtIndex(a, i, newNum);
            CFRelease(newNum);
        }

        // Print the result
        CFNumberRef resultNum = CFArrayGetValueAtIndex(a, r);
        int result = 0;
        CFNumberGetValue(resultNum, kCFNumberIntType, &result);
        printf("%d\n", result);

        // Clean up
        CFRelease(a);
    }
    return 0;
}
