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
      -g|--generate) EXPORT=1 ;;
      -d|--dryrun) EXPORT=1; DRYRUN=1 ;;
      -r|--remove) CLEANUP=1 ;;
      *) echo "$SCRIPT_NAME Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
  done
}


function usage()
{
  if [ ! -z "$1" ] ; then
    echo "$SCRIPT_NAME [ -h | -g | -d | -r ]"
    echo "   -h, --help            prints this help text"
    echo "   -g, --generate        run this script (export)"
    echo "   -d, --dryrun          same as -g but without touching antything"
    echo "   -r, --remove          remove artefacts folder ($EXPORT_FOLDER_PATH_NAME)"
    exit 1
  fi
}

# copies all files in $BMP_FILES_TO_CONVERT to $EXPORT_FOLDER_PATH_NAME
function copy_ressources()
{
  source $SCRIPT_DIR/export.cfg
  for filepath in "${BMP_FILES_TO_CONVERT[@]}" ; do
    f_basename=`basename $filepath`
    f_converted="./generated/$f_basename"

    echo "copy file $f_basename "
    echo "  -> ./generated/$f_basename"

    if [ "x$DRYRUN" != "x1" ] ; then
      cp -f "$filepath" "./"
    fi
  done
}


# converts all *.bmp files found $EXPORT_FOLDER_PATH_NAME
function convert_all_ressources()
{
  for filepath in `find . -maxdepth 1 -name "*.bmp"` ; do
    f_basename=`basename $filepath`
    
    echo "converting $f_basename"
    if [ "x$DRYRUN" != "x1" ] ; then
      convert $filepath -type truecolor $filepath
    fi
  done
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
  read_args "$1"

  usage $HELP

  pushd "$SCRIPT_DIR" > /dev/null
  cleanup $CLEANUP
  pushd "$SCRIPT_DIR/generated" > /dev/null

  if [ x"$NOARGS" == "x1" ] ; then
    usage 1
  fi

  echo -e "\nConvert .bmp files -> $EXPORT_FOLDER_PATH_NAME"
  copy_ressources
  convert_all_ressources
  
  popd > /dev/null
  popd > /dev/null
}


main "$@"
