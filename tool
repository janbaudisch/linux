#!/usr/bin/env bash

ABSOLUTE_PATH="$( cd "$(dirname "$0")"; pwd -P )"

VERSION="0.1.0"

source "${ABSOLUTE_PATH}/oo/lib/oo-bootstrap.sh"

import config/paths

STAGE0=${BUILD}/stage0
STAGE1=${BUILD}/stage1
STAGE2=${BUILD}/stage2

import scripts/chroot
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
    ${ABSOLUTE_PATH}/tool clean
    ${ABSOLUTE_PATH}/tool clean-build
    stage0
    stage1
    stage2
    ;;

("help")
    help
    ;;

("info")
    info
    ;;

("clean")
    for D in ${ABSOLUTE_PATH}/build/*; do [ -d "${D}" ] && clean_mounts $D; done
    sudo chown -R $(whoami) ${ABSOLUTE_PATH}/build
    rm -rf ${ABSOLUTE_PATH}/download
    ;;

("clean-build")
    rm -rf ${ABSOLUTE_PATH}/build
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