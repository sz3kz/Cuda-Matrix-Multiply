#ifndef MY_VECTOR_H
#define MY_VECTOR_H

#include <iostream>
#include <cstdlib>
#include <ctime>

namespace vector{
  int * initialize(unsigned int length, unsigned int upper_limit );
  void print(const char * prompt, int * vector, unsigned int length, unsigned int width);
  #ifdef __CUDACC__
  #endif
}

#endif
