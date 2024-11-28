#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int PRIME(int limit) {
    int X, SQUARE, I, K, LIM, PRIM;

    // Allocate arrays on the heap
    int *P = (int*)malloc((limit + 1) * sizeof(int));
    int *V = (int*)malloc((limit / 2 + 1) * sizeof(int));

    if (P == NULL || V == NULL) {
        printf("Memory allocation failed.\n");
        exit(1);
    }

    P[1] = 2;

    X = 1;
    LIM = 1;
    SQUARE = 4;
    int count = 1;

    for (I = 2; I <= limit; I++) {
        do {
            X += 2;

            if (X >= limit){
                free(P);
                free(V);
                return count;
            }

            if (SQUARE <= X) {
                V[LIM] = SQUARE;
                LIM++;
                SQUARE = P[LIM] * P[LIM];
            }
            K = 2;
            PRIM = 1;
            while (PRIM && K < LIM) {
                if (V[K] < X) {
                    V[K] += P[K];
                }
                PRIM = X != V[K];
                K++;
            }
        } while (!PRIM);

        P[I] = X;
        count++;
    }

    // Free the allocated memory
    free(P);
    free(V);
    return count;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <limit>\n", argv[0]);
        return 1;
    }

    int limit = atoi(argv[1]) * 100000;
    if (limit < 2) {
        printf("Limit must be at least 2.\n");
        return 1;
    }

    int count = PRIME (limit);

    printf("Number of primes less than or equal to %d: %ld\n", limit, count);
    return 0;
}