#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

function main()
{
  echo -e "\nBuild resources ..."
  pushd "$SCRIPT_DIR"  > /dev/null
  ./compile.sh
  ./deploy.sh
  popd > /dev/null
}

main
