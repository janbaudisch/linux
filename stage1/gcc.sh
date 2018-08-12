cd src/gcc

set -e

mv libitm/config/linux/x86 libitm/config/linux/x86_glibc
cp -r libitm/config/generic libitm/config/linux/x86

sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in

sed -i 's@/lib/ld-linux.so.2@/lib/ld-musl-i386.so.1@' gcc/config/i386/linux.h
sed -i 's@/lib/ld-linux.so.2@/lib/ld-musl-i386.so.1@' gcc/config/i386/linux64.h
sed -i 's@/lib64/ld-linux-x86-64.so.2@/lib/ld-musl-x86_64.so.1@' gcc/config/i386/linux64.h
sed -i 's@/lib/ld.so.1@/lib/ld-musl-powerpc.so.1@g' gcc/config/rs6000/sysv4.h
sed -i 's@/lib/ld.so.1@/lib/ld-musl-powerpc.so.1@g' gcc/config/rs6000/linux64.h
sed -i 's@/lib64/ld64.so.1@/lib/ld-musl-powerpc64.so.1@g' gcc/config/rs6000/linux64.h

sed -i 's,-lgcc_s,--start-group -lgcc_eh -lgcc -lc --end-group,' gcc/gcc.c

sed -i 's,gcc_no_link=yes,gcc_no_link=no,' libstdc++-v3/configure
mv libstdc\+\+-v3/config/os/gnu-linux libstdc\+\+-v3/config/os/gnu-linux.org
cp -r libstdc\+\+-v3/config/os/generic libstdc\+\+-v3/config/os/gnu-linux

mkdir build
cd build

../configure --prefix=/ \
	         --disable-bootstrap \
             --disable-multilib \
             --enable-languages=c,c++ \
             --disable-libstdcxx-pch \
             --disable-multilib \
             --disable-nls \
             --disable-libgomp \
             --disable-libsanitizer \
             --disable-mudflap \
             --disable-libmudflap \
             --enable-libssp \
             --disable-vtable-verify \
             --disable-gnu-indirect-function \
             --disable-libmpx \
             --disable-libquadmath \
             --enable-libstdcxx-time

make -j$(nproc)
make install

set +e
