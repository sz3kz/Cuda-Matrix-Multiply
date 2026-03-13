#include "../include/main.h"
#include "../include/vector.h"
#include "../include/interractive.h"

int main(){
  srand( static_cast<unsigned int> (time(NULL)) );
  int * host_vector_A, * host_vector_B, * host_vector_C;

  host_vector_A = vector::initialize(VECTOR_DIMENSION*VECTOR_DIMENSION, RAND_UPPER_LIMIT);
  host_vector_B = vector::initialize(VECTOR_DIMENSION*VECTOR_DIMENSION, RAND_UPPER_LIMIT);
  host_vector_C = new int [VECTOR_DIMENSION*VECTOR_DIMENSION] ();

  puts("\t\tWOLFRAM SYNTAX");
  vector::printWolfram("Vector A", host_vector_A, VECTOR_DIMENSION);
  vector::printWolfram("Vector B", host_vector_B, VECTOR_DIMENSION);

  puts("\t\tHUMAN SYNTAX");
  vector::print("Vector A", host_vector_A, VECTOR_DIMENSION, interractive::calculateWidth(RAND_UPPER_LIMIT));
  vector::print("Vector B", host_vector_B, VECTOR_DIMENSION, interractive::calculateWidth(RAND_UPPER_LIMIT));

  int * device_vector_A, * device_vector_B, * device_vector_C;

  cudaMalloc(&device_vector_A, sizeof(int) * VECTOR_DIMENSION*VECTOR_DIMENSION);
  cudaMalloc(&device_vector_B, sizeof(int) * VECTOR_DIMENSION*VECTOR_DIMENSION);
  cudaMalloc(&device_vector_C, sizeof(int) * VECTOR_DIMENSION*VECTOR_DIMENSION);

  cudaMemcpy(device_vector_A, host_vector_A, sizeof(int) * VECTOR_DIMENSION*VECTOR_DIMENSION, cudaMemcpyHostToDevice);
  cudaMemcpy(device_vector_B, host_vector_B, sizeof(int) * VECTOR_DIMENSION*VECTOR_DIMENSION, cudaMemcpyHostToDevice);
  cudaMemcpy(device_vector_C, host_vector_C, sizeof(int) * VECTOR_DIMENSION*VECTOR_DIMENSION, cudaMemcpyHostToDevice);

  // Define Each Block to have THREADS_PER_BLOCK * THREADS_PER_BLOCK threads
  // However, instead of defining it linearly, make it 2-dimensional
  // So this defines a block as having a thread-matrix of dimensions THREADS_PER_BLOCK x THREADS_PER_BLOCK
  // We take advantage of this by checking the value of threadIdx.(x|y).
  dim3 block(THREADS_PER_BLOCK, THREADS_PER_BLOCK);

  // Define the Grid itself to have something1 x something2 blocks total
  // The same as block, define it 2-dimensionally
  // We take advantage of this by checking the value of blockDim.(x|y)  and blockIdx.(x|y)
  // (VECTOR_DIMENSION + block.? - 1 / block.?) computes the number of x|y blocks
  //   needed to store the vector dimension correctly (in threads)
  dim3 grid(( VECTOR_DIMENSION + block.x - 1 ) / block.x, ( VECTOR_DIMENSION + block.y - 1) / block.y);

  // One might think that this would create a grid of blocks, of which are
  // comprised of threads, making this a 3d construct, unapplicable for 2d matrixes.
  // This is wrong.
  // This syntax, coupled with the previous 2 operations, spawns a grid of blocks
  // with the amount of blocks calculated specifically, so that there exist one
  // thread for each matrix cell (excess is ignored)
  // WRONG: 	block -> 1 matrix cell (but doable ofc)
  // CORRECT:	block -> THREADS_PER_BLOCK matrix cells, thread -> 1 matrix cell
  vector::multiply<<<grid, block>>>(device_vector_A, device_vector_B, device_vector_C, VECTOR_DIMENSION);

  cudaMemcpy(host_vector_C, device_vector_C, sizeof(int) * VECTOR_DIMENSION*VECTOR_DIMENSION, cudaMemcpyDeviceToHost);

  puts("\t\tRESULT");
  vector::print("Vector C", host_vector_C, VECTOR_DIMENSION, interractive::calculateWidth(RAND_UPPER_LIMIT));

  delete[] host_vector_A;
  delete[] host_vector_B;
  delete[] host_vector_C;

  cudaFree(device_vector_A);
  cudaFree(device_vector_B);
  cudaFree(device_vector_C);

  return 0;
}

