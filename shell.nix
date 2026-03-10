{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

pkgs.mkShell {
  name = "cuda-env";

  buildInputs = with pkgs; [
    # C++ Compiler & Build Tools
    clang # Note: CUDA often lags behind the latest GCC version
    gnumake
    cmake
    valgrind

    # CUDA Packages
    cudaPackages.cuda_nvcc
    cudaPackages.cuda_cudart
    cudaPackages.libcublas
    cudaPackages.cuda_cccl # C++ Core Compute Libraries
  ];

  shellHook = ''
    export CC=clang
    export CXX=clang++
    export CUDA_PATH=${pkgs.cudaPackages.cuda_nvcc}
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
      pkgs.cudaPackages.cuda_cudart
      pkgs.linuxPackages.nvidia_x11
    ]}:$LD_LIBRARY_PATH

    echo "CUDA Dev Environment Loaded"
    nvcc --version
  '';
}
