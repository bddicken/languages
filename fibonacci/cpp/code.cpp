#include <iostream>

int32_t fibonacci(int32_t n) {
  if (n == 0) return 0;
  if (n == 1) return 1;
  return fibonacci(n-1) + fibonacci(n-2);
}

int main (int argc, char* argv[]) {
  int32_t u = atoi(argv[1]);
  int32_t r = 0;
  for (int32_t i = 1; i < u; i++) {
    r += fibonacci(i);
  }
  std::cout<< r << std::endl;
}