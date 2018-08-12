cd src/file

set -e

./configure --prefix=/usr

make -j$(nproc)
make install

set +e
