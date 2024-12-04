#include "stdio.h"
#include "stdlib.h"
#include "stdint.h"

int32_t fibonacci(int32_t n) {
    if (n == 0) return 0;
    if (n == 1) return 1;
    int32_t a = 0, b = 1, c;
    for (int32_t i = 2; i <= n; i++) {
        c = a + b;
        a = b;
        b = c;
    }
    return b;
}

int main (int argc, char** argv) {
    if (argc < 2) {
        printf("Usage: %s <number>\n", argv[0]);
        return 1;
    }
    
    int32_t u = atoi(argv[1]);
    int32_t r = 0;
    for (int32_t i = 1; i < u; i++) {
        r += fibonacci(i);
    }
    printf("%d\n", r);
    return 0;
}
