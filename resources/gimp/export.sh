#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# $1 ... .xcf filename
function export_file_groups_to_bmp()
{
  gimp "$1" -i -b - < ../export.sch
}

# $1 ... folder containing .xcf files
function export_all_file_groups_to_bmp()
{
  #let folder="$1"
  #for f in `find .` ; do  export_file_groups_to_bmp $folder ; done

  source $SCRIPT_DIR/export.cfg
  for f in "${XCF_FILES_TO_EXPORT_FROM[@]}" ; do
    echo "exporting groups from $f ..."
    export_file_groups_to_bmp $f
    echo "done"
  done
}

function convert_all_exported_files()
{
  # convert groups to 8 bit
  for f in `find . -name "*.bmp"` ; do
    echo "converting $f to 8 bit"
    convert $f -type truecolor $f
    echo "done"
  done
}

function main()
{
  mkdir export
  pushd "$SCRIPT_DIR/export"
  export_all_file_groups_to_bmp "../"
  convert_all_exported_files
  popd
}

main
