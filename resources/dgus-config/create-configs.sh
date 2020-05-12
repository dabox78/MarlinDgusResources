#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

function main()
{
  pushd "$SCRIPT_DIR"
  rm -drf "generated"
  mkdir -p "generated"
  pushd "$SCRIPT_DIR/generated"

  source $SCRIPT_DIR/create-configs.cfg
  for txt_config in "${DGUS_HUMAN_READABLE_CONFIGURATIONS[@]}" ; do
    $SCRIPT_DIR/create-config.sh "$txt_config"
  done

  popd
  popd
}

main
