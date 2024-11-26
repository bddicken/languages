#include "stdio.h"
#include "stdlib.h"
#include "stdint.h"

int32_t fibonacci_accumulator(int32_t n, int32_t a, int32_t b) {
  if (n == 0) return a;
  return fibonacci_accumulator(n-1, b, a+b);
}
int32_t fibonacci(int32_t n) {
  return fibonacci_accumulator(n,0,1);
}

int main (int argc, char** argv) {
  int32_t u = atoi(argv[1]);
  int32_t r = 0;
  for (int32_t i = 1; i < u; i++) {
    r += fibonacci(i);
  }
  printf("%d\n", r);
}
