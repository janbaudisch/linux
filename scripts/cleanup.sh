import util/namedParameters

import log

cleanup() {
    [string] STAGE

    start "cleanup"

    sudo chown -R $(whoami) $STAGE || echo true > /dev/null

    strip --strip-unneeded ${STAGE}/bin/*
    strip --strip-unneeded ${STAGE}/usr/bin/*    
    strip --strip-debug ${STAGE}/lib/*
    strip --strip-debug ${STAGE}/usr/lib/*

    rm -rf ${STAGE}/{,usr,share,usr/share}/{doc,info,man,src}

    rm -r ${ABSOLUTE_PATH}/download

    finish "cleanup"
}
