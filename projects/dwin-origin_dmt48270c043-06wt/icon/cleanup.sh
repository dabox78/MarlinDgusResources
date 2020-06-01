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
      -g|--generate) CLEANUP=1 ;;
      -d|--dryrun) CLEANUP=1; DRYRUN=1; shift ;;
      -r|--remove) REMOVE_ARTIFACTS=1 ;;
      *) echo "$SCRIPT_NAME Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
  done
}


function usage()
{
  if [ ! -z "$1" ] ; then
    echo "$SCRIPT_NAME [ -h | -g | -d | -r ]"
    echo "   -h, --help                prints this help text"
    echo "   -g, --generate            clears artifact folders"
    echo "   -d, --dryrun              same as -g but without touching anyting"
    echo "   -r, --remove              removes artifact folders"
    exit 1
  fi
}


function cleanup()
{
  source cleanup.cfg
  for f in "${FOLDERS_TO_CLEAR[@]}" ; do
    echo "remove $f"
    if [ "$DRYRUN" != "1" ] ; then
      rm -drf $f
    fi

    if [ "$REMOVE_ARTIFACTS" != "1" ] ; then
      echo "create $f"
      mkdir -p $f
    fi
  done
}


function main()
{
  read_args "$@"
  usage $HELP

  local run_mode=""

  if [ "$DRYRUN" ==  "1" ] ; then
    run_mode=" (dry run) ..."
  else
    run_mode=" ..."
  fi
  
  echo -e "\nCleanup${run_mode}"
  pushd $SCRIPT_DIR >/dev/null
  cleanup
  popd > /dev/null
}


main "$@"
