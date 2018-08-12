cd src/cmake

set -e

CC=/toolchain/bin/gcc \
CXX=/toolchain/bin/g++ \
./bootstrap --prefix=/usr

make -j$(nproc)
make install

set +e
