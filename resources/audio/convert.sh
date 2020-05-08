#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"


# $1 ... filepath relative to script without extension
function convert_wav_file()
{
    ffmpeg -i $1.wav -acodec pcm_s16le -ac 1 -ar 32000 -y converted/$1-32khz-16bit-mono.wav
}


function convert_all_wav_files()
{
  
  for f in `find . -name "*.wav" -maxdepth 1` ; do
    f=`basename $f .wav`
    echo "converting $f"
    convert_wav_file $f
    echo "done"
  done
}

function main()
{
  pushd $SCRIPT_DIR
  mkdir converted

  convert_all_wav_files

  popd
}

main
