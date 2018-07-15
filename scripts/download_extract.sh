import util/namedParameters

import download
import extract

function download_extract() {
    [string] NAME
    [string] URL
    [string] DESTINATION
    [boolean] DONTOVERRIDE

    download $NAME $URL $FORCE

    extract $NAME $DESTINATION $DONTOVERRIDE
}
