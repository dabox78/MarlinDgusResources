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
    exit 0
  fi
}


function copy_ressources()
{
  for idx in ${!RESOURCES_FROM[*]} ; do
    from="${RESOURCES_FROM[$idx]}"
    to="${RESOURCES_TO[$idx]}"
    echo "deploy $from"
    echo "    -> $to"

    if [ -z "$DRYRUN" ] ; then
      cp -f $from $to
    fi
  done
}


function main()
{
  read_args "$@"
  usage "$HELP"

  echo -e "\nDeploy ressources ..."
  pushd "$SCRIPT_DIR" > /dev/null
  source ./tools.sh  && load_config "$BUILD_FLAVOUR" && flavour_config_deploy_sanity_check && copy_ressources
  popd > /dev/null
}


main "$@"
