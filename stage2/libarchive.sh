cd src/libarchive

set -e

mkdir builddir
cd builddir

cmake -G Ninja \
      -DCMAKE_INSTALL_PREFIX=/usr \
      ..

ninja
ninja install

set +e
