cd src/llvm

set -e

echo "patch -p1 < libcxx.patch" > patch.sh
sh patch.sh

sed -i -e 's@"-lgcc[^"]*"@"-lunwind"@g' `grep -lr '-lgcc[^"]*' .`
sed -i -e 's/linux-gnu/linux-musl/g' -e 's@LIBC=gnu@LIBC=musl@' `find . -name "confi*.guess" -o -name "confi*.sub"`
sed -i 's@linux-gnu@linux-musl@g' `grep -lr linux-gnu .`

mkdir build
cd build

CFLAGS="-O3" \
CXXFLAGS="-O3 -fpermissive" \
cmake -G Ninja \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DLLVM_TARGETS_TO_BUILD=host \
      -DCOMPILER_RT_INCLUDE_TESTS=OFF \
      -DCOMPILER_RT_BUILD_SANITIZERS=OFF \
      -DCOMPILER_RT_BUILD_XRAY=OFF \
      -DLIBCXXABI_USE_COMPILER_RT=YES \
      -DLIBCXXABI_USE_LLVM_UNWINDER=YES \
      -DLIBCXX_USE_COMPILER_RT=YES \
      ..

ninja
ninja install

cd /bin
ln -s clang cc
ln -s clang++ c++
ln -s c++ cxx
ln -s ld.lld ld

set +e
