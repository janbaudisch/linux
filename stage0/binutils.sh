import ../scripts/download_extract
import ../scripts/log

build_binutils() {
    if [ ! -f ${STAGE0}/bin/as ]
    then
        start "binutils"

        set -e

        download_extract "binutils" $BINUTILS_URL ${STAGE0}/src/binutils

        cd ${STAGE0}/src/binutils

        LDFLAGS="-Wl,-static" \
        CC="${STAGE0}/bin/musl-gcc -static" \
        CFLAGS="-static -D_GNU_SOURCE -D_LARGEFILE64_SOURCE" \
        ./configure --prefix=/ \
                    --disable-multilib \
                    --disable-shared \
                    --disable-werror \
                    --enable-initfini-array \
                    --disable-install-libbfd

        make -j$(nproc)
        make DESTDIR=${STAGE0} install

        set +e

        finish "binutils"
    else
        skip "$(UI.Color.LightMagenta)binutils$(UI.Color.Default) already built!"
    fi
}
