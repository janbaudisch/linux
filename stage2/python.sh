cd src/python

set -e

./configure --prefix=/usr

make -j$(nproc)
make install

ln -s /usr/bin/python3 /usr/bin/python

set +e
