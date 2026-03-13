# Cuda Matrix Multiply
A simple quadratic matrix multiplication program written utilizing the CUDA parallel computing platform.

## Requirements
* a C++ compiler
* CUDA developer environment
* GNU make
* Cmake

## How to use
```bash
git clone git@github.com:sz3kz/Cuda-Matrix-Multiply.git
cd Cuda-Matrix-Multiply
nix-shell # for NixOS, other linux distros should have the necessary software be available for the repository
mkdir build && cd build/
cmake ..
make
./cuda-matrix-multiply
```
