import util/log
import util/namedParameters

function log() {
    [string] MESSAGE

    echo "$(UI.Color.LightCyan)$(UI.Color.Bold)[LOG]$(UI.Color.Default) ${MESSAGE}"
}

function error() {
    [string] MESSAGE

    echo "$(UI.Color.LightRed)$(UI.Color.Bold)[ERROR]$(UI.Color.Default) ${MESSAGE}"
}

function warn() {
    [string] MESSAGE

    echo "$(UI.Color.Yellow)$(UI.Color.Bold)[WARN]$(UI.Color.Default) ${MESSAGE}"
}

function skip() {
    [string] MESSAGE

    echo "$(UI.Color.LightYellow)$(UI.Color.Bold)[SKIP]$(UI.Color.Default) ${MESSAGE}"
}

function start() {
    [string] DESCRIPTION

    echo "$(UI.Color.LightGreen)$(UI.Color.Bold)[START]$(UI.Color.Default) $(UI.Color.LightMagenta)${DESCRIPTION}$(UI.Color.Default)"
}

function finish() {
    [string] DESCRIPTION

    echo "$(UI.Color.LightGreen)$(UI.Color.Bold)[FINISH]$(UI.Color.Default) $(UI.Color.LightMagenta)${DESCRIPTION}$(UI.Color.Default)"
}
