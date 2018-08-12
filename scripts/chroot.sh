import util/namedParameters

import log

setup_root() {
    [string] CHROOT

    start "root setup"

    (
        cd $CHROOT
        mkdir -p bin dev include lib proc tmp

        # TODO: make arch-independent
        ln -s lib lib64
    )

    finish "root setup"    
}

clean_mounts() {
    [string] CHROOT

    sudo umount ${CHROOT}/dev/
    sudo umount ${CHROOT}/proc/
}

chroot_exec() {
    [string] CHROOT
    [string] SCRIPT
    [string] NAME

    start "$NAME"

    FILE=$(basename $SCRIPT)

    rm -f ${CHROOT}/${FILE}

    cp $SCRIPT ${CHROOT}/${FILE}

    if [ ! "$(ls -A ${CHROOT}/dev)" ]
    then
        sudo mount -o bind /dev ${CHROOT}/dev/
    fi

    if [ ! "$(ls -A ${CHROOT}/proc)" ]
    then
        sudo mount -t proc proc ${CHROOT}/proc/
    fi

    set -e

    SHELL=/bin/sh \
    PATH=/bin:/usr/bin:/toolchain/bin \
    CPATH=/include:/usr/include:/toolchain/include \
    LD_LIBRARY_PATH=/lib:/usr/include:/toolchain/lib \
    sudo chroot $CHROOT /bin/sh -c "sh ${FILE}; exit"

    rm ${CHROOT}/${FILE}

    clean_mounts $CHROOT

    set +e

    finish "$NAME"
}

chroot_exec_toolchain() {
    [string] CHROOT
    [string] SCRIPT
    [string] NAME

    start "$NAME"

    FILE=$(basename $SCRIPT)

    rm -f ${CHROOT}/${FILE}

    cp $SCRIPT ${CHROOT}/${FILE}

    if [ ! "$(ls -A ${CHROOT}/dev)" ]
    then
        sudo mount -o bind /dev ${CHROOT}/dev/
    fi

    if [ ! "$(ls -A ${CHROOT}/proc)" ]
    then
        sudo mount -t proc proc ${CHROOT}/proc/
    fi

    set -e

    CC=gcc
    CXX=g++

    # TODO: fix LLVM / Clang
    if [ -f $CHROOT/usr/bin/clang ]
    then
        CC=clang
        CXX=clang++
        CFLAGS="--rtlib=compiler-rt"
        CXXFLAGS="--rtlib=compiler-rt --stdlib=libc++"
    fi

    sudo chroot $CHROOT /bin/sh -c \
    "HOME=/ \
     SHELL=/toolchain/bin/sh \
     PATH=/usr/bin:/bin:/toolchain/bin \
     CPATH=/usr/include:/include:/toolchain/include \
     C_INCLUDE_PATH=/usr/include:/include:/toolchain/include \
     CPLUS_INCLUDE_PATH=/usr/include:/include:/toolchain/include \
     LD_LIBRARY_PATH=/usr/lib:/lib:/toolchain/lib \
     CC=$CC \
     CXX=$CXX \
     sh ${FILE}"

    rm ${CHROOT}/${FILE}

    clean_mounts $CHROOT

    set +e

    finish "$NAME"
}
