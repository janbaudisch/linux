import ../scripts/download_extract
import ../scripts/log

build_linux() {
    if [ ! -d ${STAGE0}/include/linux ]
    then
        start "Linux API Headers"

        set -e

        download_extract "Linux" $LINUX_URL ${STAGE0}/src/linux

        cd ${STAGE0}/src/linux

        echo "patch -p1 < ${ABSOLUTE_PATH}/files/patches/linux/uapi.patch" > patch.sh
        sh patch.sh

        make mrproper
        make INSTALL_HDR_PATH=dest headers_install

        # TODO: use install command instead
        cp -rv dest/include/* ${STAGE0}/include

        set +e

        finish "Linux API Headers"
    else
        skip "$(UI.Color.LightMagenta)Linux API Headers$(UI.Color.Default) already installed!"
    fi
}
