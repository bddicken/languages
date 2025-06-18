#import <Foundation/Foundation.h>

int fibonacci(int n) {
  if (n < 2) return n;
  return fibonacci(n-1) + fibonacci(n-2);
}
