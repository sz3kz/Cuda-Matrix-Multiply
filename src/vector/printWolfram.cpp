#include "../../include/vector.h"

void vector::printWolfram(const char * prompt, int * vector, unsigned int dimension){
  printf("%s:", prompt);

  printf("{{%d",vector[0 + 0 * dimension]);
  for (unsigned int i = 1; i < dimension; ++i)
    printf(",%d", vector[i + 0 * dimension]);
  printf("}");

  for (unsigned int j = 1; j < dimension; ++j){
    printf(",{%d", vector[0 + j * dimension]);
    for (unsigned int i = 1; i < dimension; ++i)
      printf(",%d", vector[i + j * dimension]);
    printf("}");
  }
  printf("}\n");
}
