cd src/bzip2

set -e

make -j$(nproc)
make DESTDIR=/usr install

set +e
