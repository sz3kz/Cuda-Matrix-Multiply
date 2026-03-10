#include "../include/main.h"
#include "../include/vector.h"
#include "../include/interractive.h"

int main(){
  srand( static_cast<unsigned int> (time(NULL)) );
  int * host_vector_A, * host_vector_B, * host_vector_C;

  host_vector_A = vector::initialize(VECTOR_DIMENSION*VECTOR_DIMENSION, RAND_UPPER_LIMIT);
  host_vector_B = vector::initialize(VECTOR_DIMENSION*VECTOR_DIMENSION, RAND_UPPER_LIMIT);
  host_vector_C = new int [VECTOR_DIMENSION*VECTOR_DIMENSION] ();

  vector::print("Vector A", host_vector_A, VECTOR_DIMENSION, interractive::calculateWidth(RAND_UPPER_LIMIT));
  vector::print("Vector B", host_vector_B, VECTOR_DIMENSION, interractive::calculateWidth(RAND_UPPER_LIMIT));
  vector::print("Vector C", host_vector_C, VECTOR_DIMENSION, interractive::calculateWidth(RAND_UPPER_LIMIT));

  int * device_vector_A, * device_vector_B, * device_vector_C;

  cudaMalloc(&device_vector_A, sizeof(int) * VECTOR_DIMENSION*VECTOR_DIMENSION);
  cudaMalloc(&device_vector_B, sizeof(int) * VECTOR_DIMENSION*VECTOR_DIMENSION);
  cudaMalloc(&device_vector_C, sizeof(int) * VECTOR_DIMENSION*VECTOR_DIMENSION);

  cudaMemcpy(device_vector_A, host_vector_A, sizeof(int) * VECTOR_DIMENSION*VECTOR_DIMENSION, cudaMemcpyHostToDevice);
  cudaMemcpy(device_vector_B, host_vector_B, sizeof(int) * VECTOR_DIMENSION*VECTOR_DIMENSION, cudaMemcpyHostToDevice);
  cudaMemcpy(device_vector_C, host_vector_C, sizeof(int) * VECTOR_DIMENSION*VECTOR_DIMENSION, cudaMemcpyHostToDevice);

  cudaMemcpy(host_vector_C, device_vector_C, sizeof(int) * VECTOR_DIMENSION*VECTOR_DIMENSION, cudaMemcpyDeviceToHost);

  vector::print("Vector C", host_vector_C, VECTOR_DIMENSION, interractive::calculateWidth(RAND_UPPER_LIMIT));

  delete[] host_vector_A;
  delete[] host_vector_B;
  delete[] host_vector_C;

  cudaFree(device_vector_A);
  cudaFree(device_vector_B);
  cudaFree(device_vector_C);

  return 0;
}

