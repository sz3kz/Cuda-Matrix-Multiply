#include "../../include/vector.h"

void vector::print(const char * prompt, int * vector, unsigned int dimension, unsigned int width){
  printf("%s:\n", prompt);
  for (unsigned int j = 0; j < dimension; ++j){
    for (unsigned int i = 0; i < dimension; ++i)
      printf("%*d ", width, vector[i + j * dimension]);
    printf("\n");
  }
}
