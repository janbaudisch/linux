import util/namedParameters

import log

chroot_exec() {
    [string] CHROOT
    [string] SCRIPT
    [string] NAME

    start "$NAME"

    FILE=$(basename $SCRIPT)

    rm -f ${CHROOT}/${FILE}

    cp $SCRIPT ${CHROOT}/${FILE}

    if [ ! "$(ls -A ${CHROOT}/dev)" ]
    then
        sudo mount --rbind /dev ${CHROOT}/dev
    fi

    if [ ! "$(ls -A ${CHROOT}/proc)" ]
    then
        sudo mount --rbind /proc ${CHROOT}/proc
    fi

    SHELL=/bin/sh sudo chroot $CHROOT /bin/sh -c "sh ${FILE}; exit"

    rm ${CHROOT}/${FILE}

    finish "$NAME"
}
