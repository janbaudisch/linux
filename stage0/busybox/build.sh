import ../../scripts/download_extract
import ../../scripts/log

build_busybox() {
    if [ ! -f ${STAGE0}/bin/busybox ]
    then
        start "busybox"

        set -e

        download_extract "busybox" $BUSYBOX_URL ${STAGE0}/src/busybox

        cd ${STAGE0}/src/busybox

        cp ${ABSOLUTE_PATH}/stage0/busybox/config .config

        make oldconfig
        make -j$(nproc) CC=${STAGE0}/bin/musl-gcc

        install busybox ${STAGE0}/bin

        cd ${STAGE0}/bin

        for i in $(./busybox --list)
        do
            if [ $i != "busybox" ]
            then
                ln -s busybox $i
            fi
        done

        set +e

        finish "busybox"
    else
        skip "$(UI.Color.LightMagenta)busybox$(UI.Color.Default) already built!"
    fi
}
