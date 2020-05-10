#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

source $SCRIPT_DIR/config.cfg

function run_tasks()
{
  for task in "${TASKS[@]}" ; do
    echo "running $task"
    $task
    echo -en "\n\n"
  done
}

function main()
{
  pushd "$SCRIPT_DIR"
  run_tasks
  popd
}

main
