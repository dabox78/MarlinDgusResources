#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

pushd $SCRIPT_DIR
svn export https://github.com/feathericons/feather/trunk/icons
popd

