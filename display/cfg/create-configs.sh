#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

function main()
{
  pushd "$SCRIPT_DIR"
  mkdir -p "configs_bin"
  pushd "$SCRIPT_DIR/configs_bin"

  source $SCRIPT_DIR/create-configs.cfg
  for txt_config in "${DGUS_HUMAN_READABLE_CONFIGURATIONS[@]}" ; do
    $SCRIPT_DIR/create-config.sh "$txt_config"
  done

  popd
  popd
}

main
