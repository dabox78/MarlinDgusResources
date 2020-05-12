#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"


# $1 ... source filepath relative to script
# $2 ... destination filepath relative to script
function convert_audio_file()
{
    ffmpeg -i $1 -acodec pcm_s16le -ac 1 -ar 32000 -fflags +bitexact -y -loglevel 24 $2
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

function main()
{
  pushd "$SCRIPT_DIR"
  rm -df "generated"
  mkdir -p "generated"
  convert_all_audio_files
  popd
}

main
