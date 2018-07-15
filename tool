#!/usr/bin/env bash

ABSOLUTE_PATH="$( cd "$(dirname "$0")"; pwd -P )"

VERSION="0.1.0"

source "${ABSOLUTE_PATH}/oo/lib/oo-bootstrap.sh"

import scripts/cli
import scripts/preflight
import stage0/build
import stage1/build
import stage2/build

case "$1" in
("preflight")
    preflight
    ;;

("build")
    # TODO: don't repeat if already at next stage
    stage0
    stage1
    # stage2
    ;;

("help")
    help
    ;;

("info")
    info
    ;;

("clean")
    rm -rf ${ABSOLUTE_PATH}/build
    rm -rf ${ABSOLUTE_PATH}/download
    ;;

("stage0")
    stage0
    ;;

("stage1")
    stage1
    ;;

("stage2")
    stage2
    ;;

("version")
    version
    ;;

*)
    help
    ;;

esac