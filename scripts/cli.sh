function help() {
    echo ""
    echo "    build tool"
    echo ""
    echo "        usage: tool <command>"
    echo ""
    echo "            available commands:"
    echo "                preflight - run preflight checks"
    echo "                build     - build all"
    echo "                stage0    - build only stage0"
    echo "                stage1    - build only stage1 (depends on stage0)"
    echo "                stage2    - build only stage2 (depends on stage1)"
    echo "                info      - show information regarding current configuration"
    echo "                version   - show this tools version"
    echo "                help      - show this help"
    echo "" 
}

function info() {
    import ../config/stage0/versions
    echo "stage0:"
    echo "    binutils:     ${BINUTILS_VERSION}"
    echo "    busybox:      ${BUSYBOX_VERSION}"
    echo "    GCC core:     ${GCC_CORE_VERSION}"
    echo "    linux:        ${LINUX_VERSION}"
    echo "    make:         ${MAKE_VERSION}"
    echo "    musl:         ${MUSL_VERSION}"
    echo ""
    import ../config/stage1/versions
    echo "stage1:"
    echo "    GCC:          ${GCC_VERSION}"
    echo "    GMP:          ${GMP_VERSION}"
    echo "    MPC:          ${MPC_VERSION}"
    echo "    MPFR:         ${MPFR_VERSION}"
    echo ""
    import ../config/stage2/versions
    echo "satage2:"
    echo "    busybox:      ${BUSYBOX_VERSION}"
    echo "    bzip2:        ${BZIP2_VERSION}"
    echo "    cmake:        ${CMAKE_VERSION}"
    echo "    file:         ${FILE_VERSION}"
    echo "    gettext-tiny: ${GETTEXT_TINY_VERSION}"
    echo "    gzip:         ${GZIP_VERSION}"
    echo "    libarchive:   ${LIBARCHIVE_VERSION}"
    echo "    linux:        ${LINUX_VERSION}"
    echo "    LLVM:         ${LLVM_VERSION}"
    echo "    make:         ${MAKE_VERSION}"
    echo "    musl:         ${MUSL_VERSION}"
    echo "    ninja:        ${NINJA_VERSION}"
    echo "    perl:         ${PERL_VERSION}"
    echo "    python:       ${PYTHON_VERSION}"
    echo "    Quasar M4:    ${QUASAR_M4_VERSION}"
    echo "    XZ-utils:     ${XZ_VERSION}"
    echo "    zlib:         ${ZLIB_VERSION}"
}

function version() {
    echo "build ${VERSION}"
}
