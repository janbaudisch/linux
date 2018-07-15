cd src/gcc

set -e

sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in
sed -i 's@/lib/ld-linux.so.[12]@/lib/ld-musl-i386.so.1@' gcc/config/i386/linux.h
sed -i 's@/lib/ld-linux.so.[12]@/lib/ld-musl-i386.so.1@' gcc/config/i386/linux64.h
sed -i 's@/lib64/ld-linux-x86-64.so.2@/lib/ld-musl-x86_64.so.1@' gcc/config/i386/linux64.h
sed -i 's@/lib/ld.so.1@/lib/ld-musl-powerpc.so.1@g' gcc/config/rs6000/sysv4.h
sed -i 's@/lib/ld.so.1@/lib/ld-musl-powerpc.so.1@g' gcc/config/rs6000/linux64.h
sed -i 's@/lib64/ld64.so.1@/lib/ld-musl-powerpc64.so.1@g' gcc/config/rs6000/linux64.h

sed -i 's,gcc_no_link=yes,gcc_no_link=no,' libstdc++-v3/configure
mv libstdc\+\+-v3/config/os/gnu-linux libstdc\+\+-v3/config/os/gnu-linux.org
cp -r libstdc\+\+-v3/config/os/generic libstdc\+\+-v3/config/os/gnu-linux

mkdir build
cd build

../configure --prefix=/ \
             --disable-multilib \
             --enable-languages=c,c++ \
             --disable-libstdcxx-pch \
             --disable-multilib \
             --disable-nls \
             --disable-libgomp \
             --disable-libsanitizer

make -j$(nproc) LDFLAGS="-static"
make install

set +e
