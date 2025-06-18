# Hello World

This program simply prints “Hello, World!” to standard output and then exits.
It serves as a baseline, trivial test with minimal overhead to ensure that the environment is set up and functioning correctly.

Below is the reference C program.
All languages must do the same work and meet these requirements:
-	Print exactly one line of text: “Hello, World!\n”
-	Exit with a successful status code.

```C
#include <stdio.h>

int main() {
  printf("Hello, World!\n");  // All implementations must print "Hello, World!" followed by a newline character.
  return 0;                    // All implementations must terminate successfully.
}
```
