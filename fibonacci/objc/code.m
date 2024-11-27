#import <Foundation/Foundation.h> 
  
int fibonacci(int n) {
  if (n == 0) return 0;
  if (n == 1) return 1;
  return fibonacci(n-1) + fibonacci(n-2);
}

int main(int argc, const char * argv[]) { 
  int u = [[NSString stringWithUTF8String:argv[1]] intValue];
  int r = 0;
  for (int i = 1; i < u; i++) {
    r += fibonacci(i);
  }
  NSLog(@"%d\n", r);
}