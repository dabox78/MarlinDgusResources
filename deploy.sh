#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

source $SCRIPT_DIR/config.cfg

function copy_ressources()
{
  for ressource in "${!RESOURCES[@]}" ; do
    from="$ressource"
    to="${RESOURCES[$ressource]}"
    echo "deploy $from"
    echo "  -> $to"
    cp -f $from $to
  done
}

function main()
{
  pushd "$SCRIPT_DIR"
  copy_ressources
  popd
}

main
