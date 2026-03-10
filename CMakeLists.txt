cmake_minimum_required(VERSION 3.15...4.1)

project(Cuda-Matrix-Multiply
  VERSION 1.0
  LANGUAGES CXX CUDA
)

# set C++17 as standard and enforce it as a requirement
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(cuda-matrix-multiply)

# disable compiler extensions
set(CMAKE_CXX_EXTENSIONS OFF)

# set compiler options
target_compile_options(cuda-matrix-multiply PRIVATE
    # 1. Flags for pure .cpp files (direct to Clang)
    $<$<COMPILE_LANGUAGE:CXX>:
        -Wall
        -Wextra
        -Werror
        -Weffc++
        -Wconversion
        -Wsign-conversion
        -Wpedantic
	-Wno-error=pedantic
    >

    # 2. Flags for .cu files (wrapped for NVCC)
    # Note: Use a single -Xcompiler string to keep flags bundled
    $<$<COMPILE_LANGUAGE:CUDA>:
    -Xcompiler=-Wall,-Wextra,-Werror,-Weffc++,-Wconversion,-Wsign-conversion
    -Wno-deprecated-gpu-targets
    >
)
# set up clang-tidy
set(CMAKE_CXX_CLANG_TIDY clang-tidy;
    -header-filter=./include/;
    -checks=*;
    -warnings-as-errors=*;)

# point compiler to the .h header files
target_include_directories(cuda-matrix-multiply PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)


target_sources(cuda-matrix-multiply PRIVATE
    src/main.cu
    src/interractive/calculateWidth.cpp
    src/vector/initialize.cpp
    src/vector/print.cpp
)
