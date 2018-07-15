import util/namedParameters

import log

function program_exists() {
    [string] NAME
    [string] COMMAND

    echo "$(UI.Color.LightGray)Looking for $(UI.Color.Bold)$(UI.Color.LightMagenta)${NAME}$(UI.Color.Default)$(UI.Color.LightGray)...$(UI.Color.Default)"

    command -v $COMMAND >/dev/null 2>&1 || {
        echo >&2 "$(UI.Color.Red)Could not find $(UI.Color.Bold)${NAME}$(UI.Color.Default)$(UI.Color.Red). Please check if it is installed and included in your path.$(UI.Color.Default)"
        return 1
    }

    echo "$(UI.Color.Green)Found ${NAME}!$(UI.Color.Default)"

    return 0
}

function preflight() {
    echo "$(UI.Color.LightCyan)$(UI.Color.Bold)Running preflight checks...$(UI.Color.Default)"
    echo ""
    program_exists "make" "make" || return 1
    echo ""
    program_exists "curl" "curl" || return 1
    echo ""
    program_exists "python" "python" || return 1
    echo ""
    program_exists "C compiler (CC)" "${CC}" || return 1
    echo ""
    program_exists "C++ compiler (CXX)" "${CXX}" || return 1
    echo ""
    CORES=$(nproc)
    if [ $CORES -gt 3 ]; then
        echo "CPU cores: $(UI.Color.Green)${CORES}$(UI.Color.Default)"
    else
        echo "CPU cores: $(UI.Color.LightRed)${CORES}$(UI.Color.Yellow), expect a long build time!$(UI.Color.Default)"
    fi
    echo ""
    RAM=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
    if [ $RAM -gt 4000000 ]; then
        echo "RAM available: $(UI.Color.Green)${RAM} kB$(UI.Color.Default)"
    else
        echo "RAM available: $(UI.Color.LightRed)${RAM} kB$(UI.Color.Yellow), this might not be enough!$(UI.Color.Default)"
    fi
    echo ""
    echo "$(UI.Color.LightGreen)$(UI.Color.Bold)Passed all preflight checks!$(UI.Color.Default)"
    return 0
}
