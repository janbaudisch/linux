import util/namedParameters

import log

function download() {
    [string] NAME
    [string] URL
    [boolean] FORCE

    if [ -f ${ABSOLUTE_PATH}/download/${NAME} ] && [ $FORCE != true ]
    then
        skip "$(UI.Color.LightMagenta)${NAME}$(UI.Color.Default) already downloaded."
        return 0
    fi

    if [ ! -d ${ABSOLUTE_PATH}/download ]
    then
        mkdir ${ABSOLUTE_PATH}/download
    fi

    log "Downloading $(UI.Color.LightMagenta)${NAME}$(UI.Color.Default)..."

    curl --progress-bar -Lo ${ABSOLUTE_PATH}/download/${NAME} $URL || {
        error "Download failed!"
        return 1
    }

    log "$(UI.Color.LightMagenta)${NAME}$(UI.Color.Default) donwloaded!"
}
