import ../../scripts/download_extract
import ../../scripts/log

build_gcc_core() {
    if [ ! -f ${STAGE0}/bin/gcc ]
    then
        start "GCC-core"

        set -e

        download_extract "GCC-core" $GCC_CORE_URL ${STAGE0}/src/gcc

        cd ${STAGE0}/src/gcc

        echo "patch -p1 < ${ABSOLUTE_PATH}/files/patches/gcc3/unwind2.patch" > patch.sh
        sh patch.sh
        echo "patch -p1 < ${ABSOLUTE_PATH}/files/patches/gcc3/ucontext.patch" > patch.sh
        sh patch.sh
        echo "patch -p1 < ${ABSOLUTE_PATH}/files/patches/gcc3/unlink.patch" > patch.sh
        sh patch.sh

        sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in
        sed -i 's@/lib/ld-linux.so.[12]@/lib/ld-musl-i386.so.1@' gcc/config/i386/linux.h
        sed -i 's@/lib/ld-linux.so.[12]@/lib/ld-musl-i386.so.1@' gcc/config/i386/linux64.h
        sed -i 's@/lib64/ld-linux-x86-64.so.2@/lib/ld-musl-x86_64.so.1@' gcc/config/i386/linux64.h
        sed -i 's@/lib/ld.so.1@/lib/ld-musl-powerpc.so.1@g' gcc/config/rs6000/sysv4.h
        sed -i 's@/lib/ld.so.1@/lib/ld-musl-powerpc.so.1@g' gcc/config/rs6000/linux64.h
        sed -i 's@/lib64/ld64.so.1@/lib/ld-musl-powerpc64.so.1@g' gcc/config/rs6000/linux64.h

        ./configure --prefix=/ \
                    --disable-bootstrap \
                    --disable-nls \
                    --disable-shared \
                    --disable-multilib

        make -j$(nproc) LDFLAGS="-static"
        make DESTDIR=${STAGE0} install

        set +e

        finish "GCC-core"
    else
        skip "$(UI.Color.LightMagenta)GCC-core$(UI.Color.Default) already built!"
    fi
}
