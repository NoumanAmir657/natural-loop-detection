LLVM_INSTALL_DIR=/home/nouman-10x/x86
cmake -DLLVM_INSTALL_DIR=$LLVM_INSTALL_DIR -G "Ninja" -B build/ .
cd build
cmake --build .