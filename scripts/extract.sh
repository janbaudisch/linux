import util/namedParameters

import log

function extract() {
    [string] NAME
    [string] DESTINATION
    [boolean] DONTOVERRIDE

    log "Extracting $(UI.Color.LightMagenta)${NAME}$(UI.Color.Default)..."

    if [ -d $DESTINATION ] && [ $DONTOVERRIDE != true ]
    then
        sudo chown -R $(whoami) $DESTINATION
        rm -rf $DESTINATION
    fi

    mkdir -p $DESTINATION

    tar -xf ${ABSOLUTE_PATH}/download/${NAME} --strip-components=1 -C ${DESTINATION} || {
        error "Extraction failed!"
        rm -r ${DESTINATION}
        return 1
    }

    log "$(UI.Color.LightMagenta)${NAME}$(UI.Color.Default) extracted!"
}
