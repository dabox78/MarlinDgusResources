#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"


function cleanup()
{
  source cleanup.cfg
  for f in "${FOLDERS_TO_CLEAR[@]}" ; do
    echo "remove $f"
    rm -drf $f
    mkdir -p $f
  done
}


function main()
{
  echo -e "\nCleanup ..."
  pushd $SCRIPT_DIR >/dev/null
  cleanup
  popd > /dev/null
}

main
