#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# $1 ... .xcf filename
function export_file_groups_to_bmp()
{
  gimp "$1" -i -b - < ../gimp-export.sch
}

# $1 ... folder containing .xcf files
function export_all_file_groups_to_bmp()
{
  #let folder="$1"
  #for f in `find .` ; do  export_file_groups_to_bmp $folder ; done

  files=( "../main.xcf" ) # "../temperature.xcf" )
  for f in "${files[@]}" ; do
    export_file_groups_to_bmp $f
  done
}

function main()
{
  mkdir export
  pushd "$SCRIPT_DIR/export"
  export_all_file_groups_to_bmp "../"
  popd
}

main
