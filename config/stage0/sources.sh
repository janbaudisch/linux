import versions
import ../../scripts/version

LINUX_VERSION_MAJOR=$(major ${LINUX_VERSION})

BINUTILS_URL="https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.xz"
BUSYBOX_URL="https://busybox.net/downloads/busybox-${BUSYBOX_VERSION}.tar.bz2"
GCC_CORE_URL="https://ftp.gnu.org/gnu/gcc/gcc-${GCC_CORE_VERSION}/gcc-core-${GCC_CORE_VERSION}.tar.gz"
LINUX_URL="https://cdn.kernel.org/pub/linux/kernel/v${LINUX_VERSION_MAJOR}.x/linux-${LINUX_VERSION}.tar.xz"
MAKE_URL="https://ftp.gnu.org/gnu/make/make-${MAKE_VERSION}.tar.gz"
MUSL_URL="https://www.musl-libc.org/releases/musl-${MUSL_VERSION}.tar.gz"
