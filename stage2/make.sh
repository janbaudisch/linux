cd src/make

set -e

./configure --prefix=/usr \
            --without-guile

make -j$(nproc)
make install

set +e
