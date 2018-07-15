import ../config/stage2/sources

import ../scripts/cleanup
import ../scripts/log

STAGE1=${ABSOLUTE_PATH}/build/stage1
STAGE2=${ABSOLUTE_PATH}/build/stage2

function stage2() {
    if [ ! -d $STAGE1 ] && [ ! -d $STAGE2 ]
    then
        error "stage1 not built!"
        return 1
    fi

    if [ ! -d $STAGE2 ]
    then
        mv $STAGE1 $STAGE2
    fi

    log ""
    log " ##########"
    log " # STAGE2 #"
    log " ##########"
    log ""


    cleanup $STAGE2
}
