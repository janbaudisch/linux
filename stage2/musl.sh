cd src/musl

set -e

./configure --prefix=/usr

make -j$(nproc)
make install

set +e
