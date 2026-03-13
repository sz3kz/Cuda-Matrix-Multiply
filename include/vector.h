#ifndef MY_VECTOR_H
#define MY_VECTOR_H

#include <iostream>
#include <cstdlib>
#include <ctime>

namespace vector{
  int * initialize(unsigned int length, unsigned int upper_limit );
  void print(const char * prompt, int * vector, unsigned int dimension, unsigned int width);
  void printWolfram(const char * prompt, int * vector, unsigned int dimension);
  #ifdef __CUDACC__
  __global__ void multiply(int * vectorA, int * vectorB, int * vectorC, int dimension);
  #endif
}

#endif
