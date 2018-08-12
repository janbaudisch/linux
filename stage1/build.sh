import ../config/stage1/sources

import ../scripts/chroot
import ../scripts/cleanup
import ../scripts/log

function stage1() {
    if [ ! -d $STAGE0 ] && [ ! -d $STAGE1 ]
    then
        error "stage0 not built!"
        return 1
    fi

    if [ ! -d $STAGE1 ]
    then
        mv $STAGE0 $STAGE1
    	mkdir ${STAGE1}/dev
    	mkdir ${STAGE1}/proc
    fi

    log ""
    log " ##########"
    log " # STAGE1 #"
    log " ##########"
    log ""

    set -e

    if [ ! -f ${STAGE1}/lib/libgcc_s.so ]
    then
        download_extract "GCC3" $GCC3_URL ${STAGE1}/src/gcc3

        download_extract "G++3" $GPP3_URL ${STAGE1}/src/gcc3 true

        cp ${ABSOLUTE_PATH}/files/patches/gcc/* ${STAGE1}/src/gcc3/

        chroot_exec $STAGE1 ${ABSOLUTE_PATH}/stage1/gcc3.sh "GCC3"
    fi

    if [ ! -f ${STAGE1}/binutils ]
    then
        download_extract "binutils" $BINUTILS_URL ${STAGE1}/src/binutils

        chroot_exec $STAGE1 ${ABSOLUTE_PATH}/stage1/binutils.sh "binutils"

        touch ${STAGE1}/binutils
    fi

    if [ ! -d ${STAGE1}/libexec/gcc/x86_64-pc-linux-gnu/6.4.0 ]
    then
        download_extract "GCC" $GCC_URL ${STAGE1}/src/gcc

        download_extract "GMP" $GMP_URL ${STAGE1}/src/gcc/gmp

        download_extract "MPC" $MPC_URL ${STAGE1}/src/gcc/mpc

        download_extract "MPFR" $MPFR_URL ${STAGE1}/src/gcc/mpfr

        download_extract "ISL" $ISL_URL ${STAGE1}/src/gcc/isl

        cp ${ABSOLUTE_PATH}/files/patches/gcc/* ${STAGE1}/src/gcc/

        chroot_exec $STAGE1 ${ABSOLUTE_PATH}/stage1/gcc.sh "GCC"
    fi

    set +e

    rm -f ${STAGE1}/binutils

    cleanup $STAGE1
}
