#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"


function copy_ressources()
{
  source $SCRIPT_DIR/export.cfg
  for filepath in "${BMP_FILES_TO_CONVERT[@]}" ; do
    f_basename=`basename $filepath`
    f_converted="./generated/$f_basename"

    echo "copy file $f_basename "
    echo "  -> ./generated/$f_basename"
    cp -f "$filepath" "./"
  done
}


function convert_all_ressources()
{
  # convert groups to 8 bit
  for filepath in `find . -maxdepth 1 -name "*.bmp"` ; do
    f_basename=`basename $filepath`
    
    echo "converting $f_basename"
    convert $filepath -type truecolor $filepath
  done
}


function main()
{
  pushd "$SCRIPT_DIR"
  rm -drf "generated"
  mkdir -p "generated"
  pushd "$SCRIPT_DIR/generated"
  
  copy_ressources
  convert_all_ressources
  
  popd
  popd
}

main
