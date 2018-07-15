import ../../scripts/download_extract
import ../../scripts/log

build_make() {
    if [ ! -f ${STAGE0}/bin/make ]
    then
        start "make"

        set -e

        download_extract "make" $MAKE_URL ${STAGE0}/src/make

        cd ${STAGE0}/src/make

        # TODO: make patches universal
        sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c

        CC=${STAGE0}/bin/musl-gcc \
        CFLAGS="-static -D_GNU_SOURCE" \
        LDFLAGS="-static" \
        ./configure --prefix=/ \
                    --disable-nls

        make -j$(nproc)
        make DESTDIR=${STAGE0} install

        set +e

        finish "make"
    else
        skip "$(UI.Color.LightMagenta)make$(UI.Color.Default) already built!"
    fi
}
