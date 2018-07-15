cd src/gcc

./configure --prefix=/ \
            --disable-shared \
            --enable-languages=c,c++

make -j$(nproc)
make install

exit
