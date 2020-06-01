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
    echo "   -f, --flavour <file>  configuration file name (no path)"
    echo "   -d, --dryrun <file>   same as -f but without touching anything"
    echo "   -v, --verbose         verbose"
    echo "   -r, --remove          cleanup artefacts"
    exit 0
  fi
}


function run_tasks()
{
  for task in "${TASKS[@]}" ; do
    echo -e "\nRunning task $task"

    if [ "x$DRYRUN" == "x1" ] ; then
      $task --dryrun
    elif [ "x$CLEANUP" == "x1" ] ; then
      $task --generate
    else
      $task --remove
    fi

  done
}


function main()
{
  read_args "$@"
  usage "$HELP"

  local reason=""
  if [ ! -z "$DRYRUN" ] ; then
    reason=" (dry run) ..."

  elif [ ! -z "$CLEANUP" ] ; then
    reason=" (cleanup) ..."

  else
    reason=" ..."

  fi
  
  echo -e "\nCompile ressources${reason}"
  pushd "$SCRIPT_DIR" > /dev/null
  source ./tools.sh &&  load_config "$BUILD_FLAVOUR" && flavour_config_compile_sanity_check && run_tasks
  popd > /dev/null
}

main "$@"
