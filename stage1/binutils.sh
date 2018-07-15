cd src/binutils

set -e

./configure --prefix=/ \
            --disable-multilib

make -j$(nproc)
make install

set +e
