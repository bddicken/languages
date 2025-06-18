/**
 * @file
 * @brief This file uses Google style formatting.
 */

#include "stdint.h"

int32_t fibonacci(int32_t n) {
  if (n < 2) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}
