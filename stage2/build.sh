import ../config/stage2/sources

import ../scripts/cleanup
import ../scripts/chroot
import ../scripts/log

function stage2() {
    if [ ! -d $STAGE1 ] && [ ! -d $STAGE2 ]
    then
        error "stage1 not built!"
        return 1
    fi

    if [ ! -d $STAGE2 ]
    then
        mkdir $STAGE2
        setup_root $STAGE2

        mkdir ${STAGE2}/usr
        mkdir ${STAGE2}/usr/bin
        rm -r ${STAGE2}/bin
        ln -s /usr/bin ${STAGE2}/bin
        mkdir ${STAGE2}/usr/lib
        ln -s /usr/lib ${STAGE2}/usr/lib64
        mkdir ${STAGE2}/usr/include
        rm -r ${STAGE2}/include
        ln -s /usr/include ${STAGE2}/include

        mv $STAGE1 ${STAGE2}/toolchain

        rm -r ${STAGE2}/lib
        ln -s /usr/lib ${STAGE2}/lib

        # TODO: include actual GCC version + arch
        cp ${STAGE2}/toolchain/lib/gcc/x86_64-unknown-linux-gnu/4.9.4/crt* ${STAGE2}/usr/lib/
        cp ${STAGE2}/toolchain/lib/gcc/x86_64-unknown-linux-gnu/4.9.4/libgcc* ${STAGE2}/usr/lib/
        cp ${STAGE2}/toolchain/lib/crt* ${STAGE2}/usr/lib/
        cp ${STAGE2}/toolchain/lib/libgcc* ${STAGE2}/usr/lib/

        cp ${STAGE2}/toolchain/bin/busybox ${STAGE2}/usr/bin/busybox
        cd ${STAGE2}/usr/bin
        for i in $(./busybox --list)
        do
            if [ $i != "busybox" ]
            then
                ln -s busybox $i
            fi
        done

        ln -s /bin

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/setup.sh "setup"
    fi

    log ""
    log " ##########"
    log " # STAGE2 #"
    log " ##########"
    log ""

    set -e

    if [ ! -d ${STAGE2}/usr/include/linux ]
    then
        download_extract "Linux" $LINUX_URL ${STAGE2}/src/linux

        cp ${ABSOLUTE_PATH}/files/patches/linux/* ${STAGE2}/src/linux/

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/linux.sh "Linux"
    fi

    if [ ! -f ${STAGE2}/usr/lib/libc.so ]
    then
        download_extract "musl" $MUSL_URL ${STAGE2}/src/musl

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/musl.sh "musl"
    fi

    if [ ! -f ${STAGE2}/usr/bin/libtool ]
    then
        download_extract "libtool" $LIBTOOL_URL ${STAGE2}/src/libtool

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/libtool.sh "libtool"
    fi

    if [ ! -f ${STAGE2}/usr/bin/m4 ]
    then
        download_extract "m4" $M4_URL ${STAGE2}/src/m4

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/m4.sh "m4"
    fi

    if [ ! -f ${STAGE2}/usr/bin/perl ]
    then
        download_extract "perl" $PERL_URL ${STAGE2}/src/perl

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/perl.sh "perl"
    fi

    if [ ! -f ${STAGE2}/usr/bin/autoconf ]
    then
        download_extract "autoconf" $AUTOCONF_URL ${STAGE2}/src/autoconf

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/autoconf.sh "autoconf"
    fi

    if [ ! -f ${STAGE2}/usr/bin/automake ]
    then
        download_extract "automake" $AUTOMAKE_URL ${STAGE2}/src/automake

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/automake.sh "automake"
    fi

    if [ ! -f ${STAGE2}/usr/include/obstack.h ]
    then
        download_extract "musl-obstack" $MUSL_OBSTACK_URL ${STAGE2}/src/musl-obstack

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/musl-obstack.sh "musl-obstack"
    fi

    if [ ! -f ${STAGE2}/usr/bin/cmake ]
    then
        download_extract "cmake" $CMAKE_URL ${STAGE2}/src/cmake

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/cmake.sh "cmake"
    fi

    if [ ! -f ${STAGE2}/usr/lib/libz.so ]
    then
        download_extract "zlib" $ZLIB_URL ${STAGE2}/src/zlib

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/zlib.sh "zlib"
    fi

    if [ ! -f ${STAGE2}/usr/lib/libffi.so ]
    then
        download_extract "libffi" $LIBFFI_URL ${STAGE2}/src/libffi

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/libffi.sh "libffi"
    fi

    if [ ! -f ${STAGE2}/usr/bin/python ]
    then
        download_extract "Python" $PYTHON_URL ${STAGE2}/src/python

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/python.sh "Python"
    fi

    if [ ! -f ${STAGE2}/usr/bin/ninja ]
    then
        download_extract "ninja" $NINJA_URL ${STAGE2}/src/ninja

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/ninja.sh "ninja"
    fi

    if [ ! -f ${STAGE2}/usr/bin/clang ]
    then
        download_extract "LLVM" $LLVM_URL ${STAGE2}/src/llvm

        download_extract "Clang" $CLANG_URL ${STAGE2}/src/llvm/tools/clang

        download_extract "Clang-tools-extra" $CLANG_TOOLS_URL ${STAGE2}/src/llvm/tools/clang/tools/extra

        download_extract "libcxx" $LIBCXX_URL ${STAGE2}/src/llvm/projects/libcxx

        download_extract "libcxxabi" $LIBCXXABI_URL ${STAGE2}/src/llvm/projects/libcxxabi

        download_extract "compiler-rt" $COMPILER_RT_URL ${STAGE2}/src/llvm/projects/compiler-rt

        download_extract "libunwind" $LIBUNWIND_URL ${STAGE2}/src/llvm/projects/libunwind

        download_extract "Polly" $POLLY_URL ${STAGE2}/src/llvm/tools/polly

        download_extract "OpenMP" $OPENMP_URL ${STAGE2}/src/llvm/tools/openmp

        download_extract "LLD" $LLD_URL ${STAGE2}/src/llvm/tools/lld

        cp ${ABSOLUTE_PATH}/files/patches/llvm/* ${STAGE2}/src/llvm/

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/llvm.sh "LLVM"
    fi

    if [ ! -f ${STAGE2}/2nd_musl ]
    then
        download_extract "musl" $MUSL_URL ${STAGE2}/src/musl

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/musl.sh "musl"

        touch ${STAGE2}/2nd_musl
    fi

    if [ ! -f ${STAGE2}/2nd_musl_obstack ]
    then
        download_extract "musl-obstack" $MUSL_OBSTACK_URL ${STAGE2}/src/musl-obstack

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/musl-obstack.sh "musl-obstack"

        touch ${STAGE2}/2nd_musl_obstack
    fi

    if [ ! -f ${STAGE2}/usr/lib/libssl.a ]
    then
        download_extract "libressl" $LIBRE_SSL_URL ${STAGE2}/src/libressl

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/libressl.sh "libressl"
    fi

    if [ ! -f ${STAGE2}/usr/bin/curl ]
    then
        download_extract "curl" $CURL_URL ${STAGE2}/src/curl

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/curl.sh "curl"
    fi

    if [ ! -f ${STAGE2}/usr/lib/libarchive.so ]
    then
        download_extract "libarchive" $LIBARCHIVE_URL ${STAGE2}/src/libarchive

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/libarchive.sh "libarchive"
    fi

    if [ ! -f ${STAGE2}/2nd_cmake ]
    then
        download_extract "cmake" $CMAKE_URL ${STAGE2}/src/cmake

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/cmake.sh "cmake"

        touch 2nd_cmake
    fi

    if [ ! -f ${STAGE2}/2nd_zlib ]
    then
        download_extract "zlib" $ZLIB_URL ${STAGE2}/src/zlib

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/zlib.sh "zlib"

        touch 2nd_zlib
    fi

    if [ ! -f ${STAGE2}/2nd_libffi ]
    then
        download_extract "libffi" $LIBFFI_URL ${STAGE2}/src/libffi

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/libffi.sh "libffi"

        touch 2nd_libffi
    fi

    if [ ! -f ${STAGE2}/2nd_perl ]
    then
        download_extract "perl" $PERL_URL ${STAGE2}/src/perl

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/perl.sh "perl"
    fi

    if [ ! -f ${STAGE2}/2nd_python ]
    then
        download_extract "Python" $PYTHON_URL ${STAGE2}/src/python

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/python.sh "Python"

        touch 2nd_python
    fi

    if [ ! -f ${STAGE2}/2nd_ninja ]
    then
        download_extract "ninja" $NINJA_URL ${STAGE2}/src/ninja

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/ninja.sh "ninja"

        touch 2nd_ninja
    fi

    if [ ! -f ${STAGE2}/usr/lib/libgzip.so ]
    then
        download_extract "gzip" $GZIP_URL ${STAGE2}/src/gzip

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/gzip.sh "gzip"
    fi

    if [ ! -f ${STAGE2}/usr/lib/libxz.so ]
    then
        download_extract "XZ" $XZ_URL ${STAGE2}/src/xz

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/xz.sh "XZ"
    fi

    if [ ! -f ${STAGE2}/usr/lib/libbzip2.so ]
    then
        download_extract "bzip2" $BZIP2_URL ${STAGE2}/src/bzip2

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/bzip2.sh "bzip2"
    fi

    if [ ! -f ${STAGE2}/usr/bin/file ]
    then
        download_extract "file" $FILE_URL ${STAGE2}/src/file

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/file.sh "file"
    fi

    if [ ! -f ${STAGE2}/usr/bin/make ]
    then
        download_extract "make" $MAKE_URL ${STAGE2}/src/make

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/make.sh "make"
    fi

    if [ ! -f ${STAGE2}/busybox ]
    then
        download_extract "busybox" $BUSYBOX_URL ${STAGE2}/src/busybox

        cp ${ABSOLUTE_PATH}/files/busybox/config ${STAGE2}/src/busybox/.config

        chroot_exec_toolchain $STAGE2 ${ABSOLUTE_PATH}/stage2/busybox.sh "busybox"

        touch ${STAGE2}/busybox
    fi

    set +e

    # TODO: enable when done
    rm -f ${STAGE2}/{2nd_musl,2nd_musl_obstack,2nd_cmake,2nd_zlib,2nd_libffi,2nd_perl,2nd_python,2nd_ninja,busybox}
    # cleanup $STAGE2
}
