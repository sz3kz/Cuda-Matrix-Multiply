#include "../../include/vector.h"

__global__ void vector::multiply(int * vectorA, int * vectorB, int * vectorC, int dimension){
  int cell_value = 0;
  unsigned int column_index = threadIdx.x+blockDim.x*blockIdx.x;
  unsigned int row_index = threadIdx.y+blockDim.y*blockIdx.y;
  if (row_index >= dimension || column_index >= dimension)
    return;
  for (unsigned int i = 0; i < dimension; ++i)
    cell_value += vectorA[i + row_index * dimension] *
	    vectorB[column_index + i * dimension];
  vectorC[row_index * dimension + column_index] = cell_value;
}
