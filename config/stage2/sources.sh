import versions
import ../../scripts/version

CMAKE_VERSION_MAJOR=$(major ${CMAKE_VERSION})
CMAKE_VERSION_MINOR=$(minor ${CMAKE_VERSION})
LINUX_VERSION_MAJOR=$(major ${LINUX_VERSION})
PERL_VERSION_MAJOR=$(major ${PERL_VERSION})

BUSYBOX_URL="https://busybox.net/downloads/busybox-${BUSYBOX_VERSION}.tar.bz2"
BZIP2_URL="http://bzip.org/${BZIP2_VERSION}/bzip2-${BZIP2_VERSION}.tar.gz"
CLANG_URL="http://releases.llvm.org/${LLVM_VERSION}/cfe-${LLVM_VERSION}.src.tar.xz"
CLANG_TOOLS_URL="http://releases.llvm.org/${LLVM_VERSION}/clang-tools-extra-${LLVM_VERSION}.src.tar.xz"
CMAKE_URL="https://cmake.org/files/v${CMAKE_VERSION_MAJOR}.${CMAKE_VERSION_MINOR}/cmake-${CMAKE_VERSION}.tar.gz"
COMPILER_RT_URL="http://releases.llvm.org/${LLVM_VERSION}/compiler-rt-${LLVM_VERSION}.src.tar.xz"
FILE_URL="ftp://ftp.astron.com/pub/file/file-${FILE_VERSION}.tar.gz"
GETTEXT_TINY_URL="https://github.com/sabotage-linux/gettext-tiny/archive/v${GETTEXT_TINY_VERSION}.tar.gz"
GZIP_URL="https://ftp.gnu.org/gnu/gzip/gzip-${GZIP_VERSION}.tar.xz"
LIBARCHIVE_URL="https://github.com/libarchive/libarchive/archive/v${LIBARCHIVE_VERSION}.tar.gz"
LIBCXX_URL="http://releases.llvm.org/${LLVM_VERSION}/libcxx-${LLVM_VERSION}.src.tar.xz"
LIBCXXABI_URL="http://releases.llvm.org/${LLVM_VERSION}/libcxxabi-${LLVM_VERSION}.src.tar.xz"
LIBUNWIND_URL="http://releases.llvm.org/${LLVM_VERSION}/libunwind-${LLVM_VERSION}.src.tar.xz"
LINUX_URL="https://cdn.kernel.org/pub/linux/kernel/v${LINUX_VERSION_MAJOR}.x/linux-${LINUX_VERSION}.tar.xz"
LLD_URL="http://releases.llvm.org/${LLVM_VERSION}/lld-${LLVM_VERSION}.src.tar.xz"
LLVM_URL="http://releases.llvm.org/${LLVM_VERSION}/llvm-${LLVM_VERSION}.src.tar.xz"
MAKE_URL="https://ftp.gnu.org/gnu/make/make-${MAKE_VERSION}.tar.gz"
MUSL_URL="https://www.musl-libc.org/releases/musl-${MUSL_VERSION}.tar.gz"
NETBSD_CURSES_URL="https://github.com/sabotage-linux/netbsd-curses/archive/v${NETBSD_CURSES_VERSION}.tar.gz"
NINJA_URL="https://github.com/ninja-build/ninja/archive/v${NINJA_VERSION}.tar.gz"
OPENMP_URL="https://releases.llvm.org/${LLVM_VERSION}/openmp-${LLVM_VERSION}.src.tar.xz"
PERL_URL="https://www.cpan.org/src/${PERL_VERSION_MAJOR}.0/perl-${PERL_VERSION}.tar.gz"
POLLY_URL="http://releases.llvm.org/${LLVM_VERSION}/polly-${LLVM_VERSION}.src.tar.xz"
PYTHON3_URL="https://www.python.org/ftp/python/${PYTHON3_VERSION}/Python-${PYTHON3_VERSION}.tar.xz"
QUASAR_M4_URL="http://haddonthethird.net/m4/m4-${QUASAR_M4_VERSION}.tar.bz2"
XZ_URL="https://tukaani.org/xz/xz-${XZ_VERSION}.tar.gz"
ZLIB_URL="https://www.zlib.net/zlib-${ZLIB_VERSION}.tar.gz"
