#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SCRIPT_NAME=`basename "$0"`


function read_args()
{
  if [ "$#" -eq 0 ] ; then
    NOARGS=1
  fi

  while [[ "$#" -gt 0 ]]; do
    case $1 in
      -h|--help) HELP=1 ;;
      -f|--flavour) BUILD_FLAVOUR="$2"; shift ;;
      -d|--dryrun) BUILD_FLAVOUR="$2"; DRYRUN=1; shift ;;
      -l|--list) LIST_CONFIGS=1 ;;
      -r|--remove) CLEANUP=1 ;;
      *) echo "$SCRIPT_NAME Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
  done
}


function usage()
{
  if [ ! -z "$1" ] ; then
    echo "$SCRIPT_NAME [ -h | -f <file.cfg> | -d <file.cfg> | -l | -r ]"
    echo "   -h, --help                prints this help text"
    echo "   -f, --flavour <file.cfg>  configuration file name (no path); default: $FLAVOUR_CONFIG"
    echo "   -d, --dryrun <file.cfg>   same as -f but without touching anyting"
    echo "   -l, --list                list configurations"
    echo "   -r, --remove              cleanup artefacts"
    exit 1
  fi
}


function list_configurations()
{
  if [ ! -z "$1" ] ; then
    for f in `find $FLAVOUR_PATH -regex .*cfg$` ; do
      echo "$f"
    done
    exit 0
  fi
}


function main()
{
  read_args "$@"

  pushd "$SCRIPT_DIR"  > /dev/null

  source ./tools.sh && load_config "$BUILD_FLAVOUR" && list_configurations "$LIST_CONFIGS"
  usage "$HELP"

  local reason=""
  local compile_args=""
  local deploy_args=""
  if [ ! -z "$DRYRUN" ] ; then
    reason=" (dry run) ..."
    compile_args="--dryrun $BUILD_FLAVOUR"
    deploy_args="--dryrun"
  elif [ ! -z "$CLEANUP" ] ; then
    reason=" (cleanup) ..."
    compile_args="--remove"
    deploy_args="--remove"
  else
    reason=" ..."
    compile_args="--flavour $BUILD_FLAVOUR"
    deploy_args="--generate"
  fi

  echo -e "\nBuild project $FLAVOUR_CONFIG${reason}\n"
  print_config_info

  ./compile.sh $compile_args && ./deploy.sh "$deploy_args"

  popd > /dev/null
}

main "$@"
