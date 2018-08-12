cd src/musl-obstack

sed -i "/pkgconfig_DATA/i pkgconfigdir=\/usr/lib/pkgconfig" Makefile.am
./bootstrap.sh
./configure --prefix=/usr

make -j$(nproc)
make install
