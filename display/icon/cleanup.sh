#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"


function cleanup()
{
  source cleanup.cfg
  for f in "${FOLDERS_TO_CLEAR[@]}" ; do
    rm -drf $f
    mkdir -p $f
  done
}


function main()
{
  pushd $SCRIPT_DIR
  cleanup
  popd
}

main
