import ../scripts/download_extract
import ../scripts/log

build_bash() {
    if [ ! -f ${STAGE0}/bin/bash ]
    then
        start "bash"

        set -e

        download_extract "bash" $BASH_URL ${STAGE0}/src/bash

        cd ${STAGE0}/src/bash

        LDFLAGS="-Wl,-static" \
        CC="${STAGE0}/bin/musl-gcc -static" \
        CFLAGS="-static -D_GNU_SOURCE -D_LARGEFILE64_SOURCE" \
        ./configure --prefix=/ \
                    --disable-shared

        make -j$(nproc)
        make DESTDIR=${STAGE0} install

        set +e

        finish "bash"
    else
        skip "$(UI.Color.LightMagenta)bash$(UI.Color.Default) already built!"
    fi
}
