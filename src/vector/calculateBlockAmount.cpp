#include "../../include/vector.h"

unsigned int vector::calculateBlockAmount(unsigned int dimension, unsigned int threads_per_block){
  return (dimension + threads_per_block - 1) / threads_per_block;
}
