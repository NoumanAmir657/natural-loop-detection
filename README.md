## Build
```
LLVM_INSTALL_DIR=<path_to_llvm_build>

cmake -DLLVM_INSTALL_DIR=$LLVM_INSTALL_DIR -G "Ninja" -B build/ .

cd build

cmake --build .
```

## Run
```
opt -load-pass-plugin build/lib/libPass.so -passes=my_pass -S foo.ll
```

## Generate CFG
```
opt -passes='dot-cfg' -S -disable-output test/nnLoop.ll
dot -Tpng -o .foo.dot test/foo.png
rm .foo.dot
```