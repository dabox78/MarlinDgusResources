#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# crdates .cfg file in the current working directory
# $1 ... .txt source config file
function compile_configuration()
{
  filepath="$1"
  echo "xxx compiling from $1"
  f_basename=`basename $filepath`
  f_name_wo_extension=${f_basename%%.*}    
  f_compiled="./${f_name_wo_extension}.cfg"

  echo "create configuration from $f_basename"
  echo "  -> $f_compiled"
  cat $1 | xxd -c 1 -r > $f_compiled
}


function main()
{
  compile_configuration "$1"
}

main $1
