#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>												                                   // include this for the write function
#include <time.h>                                                           // time.h added to seed rng

int main (int argc, char **argv) {
    
	register uint32_t u = 40;				                                       // Get an input number from the command line (uint32_t)atoi(argv[1])
	srand(time(NULL));                                                    // Seed the random number generator
	register uint32_t r = (uint32_t)(rand() % 10000);                    // Get a random unsigned integer 0 <= r < 10k
	uint32_t a[10000] = {0};									                          // Array of 10k elements initialized to 0
	register uint32_t x = 0;									                         // Iterator for printing the integer
	char buffer[12]; 											                            // Buffer big enough to hold a signed integer

	for (register uint16_t i= 0; i < 10000; i++) {				          // 10k outer loop iterations
		for (register uint32_t j= 0; j< 100000; j++) {			         // 100k inner loop iterations, per outer loop iteration
			a[i] += (j % u);									                        // "Simple sum"
		}
		a[i] += r;												                         // Add a random value to each element in array
	}
                                                             // Get the decimal lenght of a[r] ASAP
x = (a[r] >= 1000000000) ? 9 : (a[r] >= 100000000) ? 8 : (a[r] >= 10000000) ? 7 : 
    (a[r] >= 1000000) ? 6 : (a[r] >= 100000) ? 5 : (a[r] >= 10000) ? 4 : 
    (a[r] >= 1000) ? 3 : (a[r] >= 100) ? 2 : (a[r] >= 10) ? 1 : 0;
    
    switch (x) {                                          // Unwinded loop to reverse integer
    case 9:
        buffer[9] = (a[r] % 10) + '0';
        a[r] /= 10;
    case 8:
        buffer[8] = (a[r] % 10) + '0';
        a[r] /= 10;
    case 7:
        buffer[7] = (a[r] % 10) + '0';
        a[r] /= 10;
    case 6:
        buffer[6] = (a[r] % 10) + '0';
        a[r] /= 10;
    case 5:
        buffer[5] = (a[r] % 10) + '0';
        a[r] /= 10;
    case 4:
        buffer[4] = (a[r] % 10) + '0';
        a[r] /= 10;
    case 3:
        buffer[3] = (a[r] % 10) + '0';
        a[r] /= 10;
    case 2:
        buffer[2] = (a[r] % 10) + '0';
        a[r] /= 10;
    case 1:
        buffer[1] = (a[r] % 10) + '0';
        a[r] /= 10;
    case 0:
        buffer[0] = a[r] + '0';
    break;
}

    write(STDOUT_FILENO, buffer, x);                     // Print out the integer
    putchar('\n');												              // Print out a new line
	return 0;
}
