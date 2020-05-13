#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

source $SCRIPT_DIR/build.cfg

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
  echo "\nCompile ressources ..."
  pushd "$SCRIPT_DIR" > /dev/null
  run_tasks
  popd > /dev/null
}

main
