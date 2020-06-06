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
      -g|--generate) CONVERT=1 ;;
      -d|--dryrun) CONVERT=1; DRYRUN=1 ;;
      -r|--remove) CLEANUP=1 ;;
      *) echo "$SCRIPT_NAME Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
  done
}


function usage()
{
  if [ ! -z "$1" ] ; then
    echo "$SCRIPT_NAME [-h] [-g|-d] [-r]"
    echo ""
    echo "  -h, --help"
    echo "        prints this help text"
    echo "  -g, --generate"
    echo "        run this script (convert)"
    echo "  -d, --dryrun"
    echo "        same as -g but without touching anything"
    echo "  -r, --remove"
    echo "        remove artefacts folder ($EXPORT_FOLDER_PATH_NAME)"
    exit 1
  fi
}


# $1 ... source filepath relative to script
# $2 ... destination filepath relative to script
function convert_audio_file()
{
  if [ "x$DRYRUN" != "x1" ] ; then
    ffmpeg -i $1 -acodec pcm_s16le -ac 1 -ar 32000 -fflags +bitexact -y -loglevel 24 $2
  fi
}


function convert_all_audio_files()
{
  for filepath in `find . -maxdepth 1 -regex ".*wav\|.*ogg\|.*mp3"` ; do
    f_basename=`basename $filepath`
    f_name_wo_extension=${f_basename%%.*}    
    f_converted="./generated/${f_name_wo_extension}.wav"
    
    echo "converting $f_basename"
    echo "  -> $f_converted"
    convert_audio_file "$f_basename" "$f_converted"
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

  if  [ -z "$CONVERT" ] ; then
    usage 1
  fi

  echo -e "\nConvert audio files -> $EXPORT_FOLDER_NAME"
  convert_all_audio_files
  popd > /dev/null
}


main "$@"
