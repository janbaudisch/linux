cd src/gzip

set -e

./configure --prefix=/usr

make -j$(nproc)
make install

set +e
