#ifndef LEVENSHTEIN_
#define LEVENSHTEIN_H

#include "stdint.h"

typedef struct {
  long* distances;
  int count;
} distances_result_t;

distances_result_t* distances(char** words, int word_count);

#endif // LEVENSHTEIN_H