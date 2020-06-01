#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SCRIPT_NAME=`basename "$0"`

EXPORT_FOLDER_NAME="generated"
EXPORT_FOLDER_PATH_NAME="$SCRIPT_DIR/$EXPORT_FOLDER_NAME"


function read_args()
{
  if [ "$#" -eq 0 ] ; then
    NOARGS=1
  fi

  while [[ "$#" -gt 0 ]]; do
    case $1 in
      -h|--help) HELP=1 ;;
      -g|--generate) CREATE_CONFIGS=1 ;;
      -d|--dryrun) CREATE_CONFIGS=1; DRYRUN=1 ;;
      -r|--remove) CLEANUP=1 ;;
      *) echo "$SCRIPT_NAME Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
  done
}


function usage()
{
  if [ ! -z "$1" ] ; then
    echo "$SCRIPT_NAME [ -h | -g <file.txt> | -d | -r ]"
    echo "   -h, --help            prints this help text"
    echo "   -g, --generate        compile configuration files to binary format"
    echo "   -d, --dryrun          same as -g but without touching anything"
    echo "   -r, --remove          remove artefacts folder ($EXPORT_FOLDER_PATH_NAME)"
    exit 1
  fi
}


function cleanup()
{
  echo "Cleaning artefact folder '$EXPORT_FOLDER_NAME'"
  rm -drf "$EXPORT_FOLDER_NAME"
  if [ "x$CLEANUP" == "x1" ] ; then
    exit 0
  fi
  mkdir -p "$EXPORT_FOLDER_NAME"
}


function main()
{
  read_args "$@"

  usage $HELP

  if  [ x"$NOARGS" == "x1" ] ; then
    usage 1
  fi

  pushd "$SCRIPT_DIR" > /dev/null
  cleanup $CLEANUP
  pushd "$SCRIPT_DIR/generated" > /dev/null

  if [ -z "$CREATE_CONFIGS" ] ; then
    usage 1
  fi

  local run_mode=""
  local task_run_mode=""
  if [ "x$DRYRUN" == "x1" ] ; then
    task_run_mode="--dryrun"
    run_mode=" (dry run) ..."
  else
    task_run_mode="--generate"
    run_mode=" ..."
  fi
  
  echo -e "\nCompile .txt configuration files -> $EXPORT_FOLDER_PATH_NAME${run_mode}"
    
  source $SCRIPT_DIR/create-configs.cfg
  for txt_config in "${DGUS_HUMAN_READABLE_CONFIGURATIONS[@]}" ; do
    $SCRIPT_DIR/create-config.sh $task_run_mode $txt_config
  done

  popd > /dev/null
  popd > /dev/null
}


main "$@"
