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
      -s|--sync) SYNC_REMOVABLE_DEVICE="$2"; shift; ;;
      *) echo "$SCRIPT_NAME Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
  done
}


function usage()
{
  if [ ! -z "$1" ] ; then
    echo "$SCRIPT_NAME [-h] [[-f|-d] <file.cfg>] [-l] [-r] [-s]"
    echo ""
    echo "  -h, --help"
    echo "        print this help text"
    echo "  -f, --flavour <file.cfg>"
    echo "        configuration file name; default: $FLAVOUR_CONFIG"
    echo "  -d, --dryrun <file.cfg>"
    echo "        same as -f but without touching anyting"
    echo "  -l, --list"
    echo "        list possible configurations"
    echo "  -r, --remove"
    echo "        cleanup artefacts"
    echo "  -s, --sync <device_mount_root_path>"
    echo "        sync DWIN_SET to removable device and unmount device, optionally use with --flavour"
    exit 1
  fi
}


function list_configurations()
{
  if [ ! -z "$1" ] ; then
    pushd $FLAVOUR_PATH > /dev/null
    for f in `find ./ -regex .*cfg$ -printf %f` ; do
      echo "$f"
    done
    popd > /dev/null
    exit 0
  fi
}


function sync_device()
{
  local removable_device="$1"
  if [ ! -z "$removable_device" ] ; then
    copy_project_to_removable_disk ${SCRIPT_DIR}/${DWIN_PROJECT_BASE} $removable_device && exit 0
    echo "failed to sync project device: '$DWIN_PROJECT_BASE' -> '$removable_device'"
    exit 1
  fi
}

function main()
{
  read_args "$@"

  pushd "$SCRIPT_DIR"  > /dev/null

  source ./tools.sh && load_config "$BUILD_FLAVOUR" && flavour_config_basic_sanity_check \
  && list_configurations "$LIST_CONFIGS"
  usage "$HELP"

  sync_device $SYNC_REMOVABLE_DEVICE

  local run_mode=""
  local build_args=""  
  if [ ! -z "$DRYRUN" ] ; then
    run_mode=" (dry run)"
    build_args="--dryrun $BUILD_FLAVOUR"
  elif [ ! -z "$CLEANUP" ] ; then
    run_mode=" (cleanup)"
    build_args="--remove"
  else
    build_args="--flavour $BUILD_FLAVOUR"
  fi

  echo -e "\nBuild project $FLAVOUR_CONFIG${run_mode} ...\n"
  print_config_info

  ./compile.sh $build_args && ./deploy.sh $build_args && echo -e "\n$SCRIPT_NAME finished successfully${run_mode}.\n"

  popd > /dev/null
}

main "$@"
