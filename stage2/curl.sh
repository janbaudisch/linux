cd src/curl

set -e

mkdir build
cd build

cmake -G Ninja \
      -DCMAKE_INSTALL_PREFIX=/usr \
      ..

ninja
ninja install

set +e
