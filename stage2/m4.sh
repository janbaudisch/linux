cd src/m4

set -e

./configure --prefix=/usr

make -j$(nproc)
make install

set +e
