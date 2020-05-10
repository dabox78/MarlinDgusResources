#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

function main()
{
  pushd "$SCRIPT_DIR"

  ./compile.sh
  ./deploy.sh

  popd
}

main
