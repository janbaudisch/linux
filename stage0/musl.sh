import ../scripts/download_extract
import ../scripts/log

build_musl() {
    if [ ! -f ${STAGE0}/lib/libc.a ]
    then
        start "musl"

        set -e

        download_extract "musl" $MUSL_URL ${STAGE0}/src/musl

        cd ${STAGE0}/src/musl

        CC=${STAGE0}/bin/gcc \
        ./configure --prefix=${STAGE0} \
                    --syslibdir=${STAGE0}/lib \
                    --enable-gcc-wrapper

        make -j$(nproc) CC=${STAGE0}/bin/gcc
        make install

        set +e

        finish "musl"
    else
        skip "$(UI.Color.LightMagenta)musl$(UI.Color.Default) already built!"
    fi
}
