import ../config/stage0/sources

import ../scripts/cleanup
import ../scripts/chroot
import ../scripts/log

import binutils
import busybox
import gcc-core
import linux
import make
import musl

function stage0() {
    if [ ! -d $STAGE0 ]
    then
        mkdir -p $STAGE0
        setup_root $STAGE0
    fi

    export PATH=${PATH}:${STAGE0}/bin
    export CPATH=${STAGE0}/include:${CPATH}
    export LD_LIBRARY_PATH=${STAGE0}/lib:${LD_LIBRARY_PATH}

    log ""
    log " ##########"
    log " # STAGE0 #"
    log " ##########"
    log ""

    build_linux

    build_gcc_core

    build_musl

    build_busybox

    build_binutils

    build_make

    sed -i -e  's|'$STAGE0'||g' ${STAGE0}/bin/musl-gcc
    sed -i -e  's|'$STAGE0'||g' ${STAGE0}/lib/musl-gcc.specs

    # TODO: make arch-independent
    cd ${STAGE0}/lib
    rm ld-musl-x86_64.so.1
    ln -s libc.so ld-musl-x86_64.so.1

    cleanup $STAGE0

    cd $STAGE0

    if [ ! -d usr ]
    then
        ln -s . usr
    fi

    if [ ! -d lib64 ]
    then
        ln -s lib lib64
    fi

    cd ${ABSOLUTE_PATH}
}
