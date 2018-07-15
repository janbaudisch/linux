import util/namedParameters

function major() {
    [string] VERSION

    IFS='.' read -ra PARSED <<< "$VERSION"
    
    echo ${PARSED[0]}
}

function minor() {
    [string] VERSION

    IFS='.' read -ra PARSED <<< "$VERSION"
    
    echo ${PARSED[1]}
}

function patch() {
    [string] VERSION

    IFS='.' read -ra PARSED <<< "$VERSION"
    
    echo ${PARSED[2]}
}
