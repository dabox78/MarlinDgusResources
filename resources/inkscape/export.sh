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


# TODO
## $1 ... .xcf filename
#function export_file_groups_to_bmp()
#{
#  if [ "x$DRYRUN" != "x1" ] ; then
#    gimp "$1" -i -b - < ../export.sch
#  fi
#}


function export_all_file_groups_to_bmp()
{
  source $SCRIPT_DIR/export.cfg
  for f in "${XCF_FILES_TO_EXPORT_FROM[@]}" ; do
    echo "exporting groups from $f ..."
    # TODO
    # export_file_groups_to_bmp $f
    echo "done"
  done
}


function convert_all_exported_files()
{
  # convert groups
  for f in `find . -maxdepth 1 -name "*.bmp"` ; do
    echo "convert $f to 8 bit"
    convert $f -type truecolor $f
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
  read_args "$@"
  usage $HELP

  if  [ x"$NOARGS" == "x1" ] ; then
    usage 1
  fi

  pushd "$SCRIPT_DIR" > /dev/null
  cleanup $CLEANUP
  pushd "$EXPORT_FOLDER_PATH_NAME" > /dev/null

  if  [ -z "$EXPORT" ] ; then
    usage 1
  fi
  
  echo -e "\nExport from .xcf -> $EXPORT_FOLDER_PATH_NAME"
  export_all_file_groups_to_bmp "../"
  convert_all_exported_files
  
  popd > /dev/null
  popd > /dev/null
}


main "$@"
