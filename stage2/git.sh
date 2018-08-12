cd src/git

set -e

make prefix=/usr -j$(nproc)
make prefix=/usr install

set +e
