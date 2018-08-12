cd src/perl

sed -i 's,-fstack-protector,-fnostack-protector,g' ./Configure

./Configure -des \
            -Dcc=gcc \
            -Accflags="-D_GNU_SOURCE -D_BSD_SOURCE -fPIC" \
            -Dprefix="/usr"

make -j$(nproc)
make install
