#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SCRIPT_NAME=`basename "$0"`


function read_args()
{
  while [[ "$#" -gt 0 ]]; do
    case $1 in
      -h|--help)    HELP="1" ;;
      -f|--flavour) BUILD_FLAVOUR="$2"; shift ;;
      -v|--verbose) VERBOSE="1" ;;
      -d|--dryrun)  DRYRUN="1" ;;
      -l|--list)    LIST_CONFIGS="1" ;;
      *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
  done
}


function usage()
{
  if [ ! -z "$1" ] ; then
    echo "$SCRIPT_NAME [ -h | -f <file> | -v | -d ]"
    echo "   -h, --help            prints this help text"
    echo "   -f, --flavour <file>  configuration file name (no path)"
    echo "   -v, --verbose         verbose"
    echo "   -d, --dryrun          dryrun"
    echo "   -l, --list            list configurations"
    exit 0
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
  usage "$HELP"

  pushd "$SCRIPT_DIR"  > /dev/null

  source ./tools.sh && load_config "$BUILD_FLAVOUR" && list_configurations "$LIST_CONFIGS"

  local reason=" ..."
  if [ ! -z "$DRYRUN" ] ; then
    reason=" (dry run) ..."
  fi

  echo -e "\nBuild project $FLAVOUR_CONFIG${reason}\n"
  print_config_info

  ./compile.sh "$@" && ./deploy.sh "$@"

  popd > /dev/null
}

main "$@"
