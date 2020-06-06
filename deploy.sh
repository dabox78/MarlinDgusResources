#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SCRIPT_NAME=`basename "$0"`


function read_args()
{
  while [[ "$#" -gt 0 ]]; do
    case $1 in
      -h|--help)    HELP="1" ;;
      -f|--flavour) BUILD_FLAVOUR="$2"; shift ;;
      -d|--dryrun)  BUILD_FLAVOUR="$2"; DRYRUN="1"; shift ;;
      *) echo "$SCRIPT_NAME Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
  done
}


function usage()
{
  if [ ! -z "$1" ] ; then
    echo "$SCRIPT_NAME [-h] [[-f|-d] <file>]"
    echo ""
    echo "  -h, --help"
    echo "        prints this help text"
    echo "  -f, --flavour <file>"
    echo "        configuration file name; default: $FLAVOUR_CONFIG"
    echo "  -d, --dryrun <file>"
    echo "        same as -f but without touching anything"
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

    if [ "x$DRYRUN" != "x1" ] ; then
      cp -f $from $to

    if [ "x$?" != "x0" ] ; then
      echo "Failed to deploy from '$from' -> '$to'"
      exit 1
    fi
    fi
  done
}


function main()
{
  read_args "$@"
  source ./tools.sh  && load_config "$BUILD_FLAVOUR" && flavour_config_deploy_sanity_check
  usage "$HELP"

  local run_mode=""
  if [ ! -z "$DRYRUN" ] ; then
    run_mode=" (dry run)"

  elif [ ! -z "$CLEANUP" ] ; then
    run_mode=" (cleanup)"

  else
    run_mode=""
  fi

  echo -e "\nDeploy ressources${run_mode} ..."
  pushd "$SCRIPT_DIR" > /dev/null
  copy_ressources && echo -e "\n$SCRIPT_NAME finished successfully${run_mode}.\n"
  popd > /dev/null
}


main "$@"
