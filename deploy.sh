#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

source $SCRIPT_DIR/build.cfg

function copy_ressources()
{
  for idx in ${!RESOURCES_FROM[*]} ; do
    from="${RESOURCES_FROM[$idx]}"
    to="${RESOURCES_TO[$idx]}"
    echo "deploy $from"
    echo "  -> $to"
    cp -f $from $to
  done
}

function main()
{
  echo "\nDeploy ressources ..."
  pushd "$SCRIPT_DIR" > /dev/null
  copy_ressources
  popd > /dev/null
}

main
