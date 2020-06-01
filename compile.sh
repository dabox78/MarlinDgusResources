#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SCRIPT_NAME=`basename "$0"`


function read_args()
{
  while [[ "$#" -gt 0 ]]; do
    case $1 in
      -h|--help) HELP=1 ;;
      -f|--flavour) BUILD_FLAVOUR="$2" ; shift ;;
      -v|--verbose) VERBOSE=1 ;;
      -d|--dryrun) BUILD_FLAVOUR="$2"; DRYRUN=1; shift ;;
      -r|--remove) CLEANUP=1 ;;
      *) echo "$SCRIPT_NAME Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
  done
}


function usage()
{
  if [ ! -z "$1" ] ; then
    echo "$SCRIPT_NAME [ -h | -f <file> | -d | -v | -r ]"
    echo "   -h, --help            prints this help text"
    echo "   -f, --flavour <file>  configuration file name; default: $FLAVOUR_CONFIG"
    echo "   -d, --dryrun <file>   same as -f but without touching anything"
    echo "   -v, --verbose         verbose"
    echo "   -r, --remove          cleanup artefacts"
    exit 0
  fi
}


function run_tasks()
{
  for task in "${TASKS[@]}" ; do
    

    local task_arguments=""
    if [ "x$DRYRUN" == "x1" ] ; then
      task_arguments="--dryrun"
    elif [ "x$CLEANUP" == "x1" ] ; then
      task_arguments="--remove"
    else
      task_arguments="--generate"
    fi

    echo -e "\nRunning task $task $task_arguments"
    $task $task_arguments
    if [ "x$?" != "x0" ] ; then
      echo "Failed to execute task: '$task $task_arguments'"
      exit 1
    fi

  done
}


function main()
{
  read_args "$@"

  source ./tools.sh && load_config "$BUILD_FLAVOUR" && flavour_config_compile_sanity_check
  usage "$HELP"

  local run_mode=""
  if [ ! -z "$DRYRUN" ] ; then
    run_mode=" (dry run)"

  elif [ ! -z "$CLEANUP" ] ; then
    run_mode=" (cleanup)"

  else
    run_mode=""
  fi
  
  echo -e "\nCompile ressources${run_mode} ..."
  pushd "$SCRIPT_DIR" > /dev/null
  run_tasks && echo -e "\n$SCRIPT_NAME finished successfully${run_mode}.\n"
  popd > /dev/null
}

main "$@"
