#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SCRIPT_NAME=`basename "$0"`


FLAVOUR_PATH="${SCRIPT_DIR}/build-flavours"
FLAVOUR_CONFIG="debian-red_dgus-origin_dmt48270c043-06wt.cfg" 
FLAVOUR_CONFIG_FILEPATH="${FLAVOUR_PATH}/${FLAVOUR_CONFIG}"

function load_config()
{
  local user_flavour_file="$1"
  if [ ! -z "$user_flavour_file" ] ; then
      FLAVOUR_CONFIG="$user_flavour_file" 
      FLAVOUR_CONFIG_FILEPATH="${FLAVOUR_PATH}/${FLAVOUR_CONFIG}" SCRIPT_NAME="$0"
  fi

  if [ ! -f "$FLAVOUR_CONFIG_FILEPATH" ] ; then
    echo "Failed to load configuration \"$FLAVOUR_CONFIG_FILEPATH\"."
    exit 1
  else
    source $FLAVOUR_CONFIG_FILEPATH
  fi
}


function flavour_config_basic_sanity_check()
{
  if [ -z "$FLAVOUR" ] ; then
      echo "Variable FLAVOUR is not set in ${FLAVOUR_PATH}/${FLAVOUR_CONFIG}."
      exit 1
  fi
  if [ -z "$EXTUI" ] ; then
      echo "Variable EXTUI is not set in ${FLAVOUR_PATH}/${FLAVOUR_CONFIG}."
      exit 1
  fi
  if [ -z "$HARDWARE" ] ; then
      echo "Variable HARDWARE is not set in ${FLAVOUR_PATH}/${FLAVOUR_CONFIG}."
      exit 1
  fi
}


function flavour_config_compile_sanity_check()
{
  flavour_config_basic_sanity_check
  
  if [ -z "$TASKS" ] ; then
      echo "Variable TASKS is not set in ${FLAVOUR_PATH}/${FLAVOUR_CONFIG}."
      exit 1
  fi
  return 0
}


function flavour_config_deploy_sanity_check()
{
  flavour_config_basic_sanity_check
  
  if [ -z "$RESOURCES_FROM" ] ; then
      echo "Variable RESOURCES_FROM is not set in ${FLAVOUR_PATH}/${FLAVOUR_CONFIG}."
      exit 1
  fi
  if [ -z "$RESOURCES_TO" ] ; then
      echo "Variable RESOURCES_TO is not set in ${FLAVOUR_PATH}/${FLAVOUR_CONFIG}."
      exit 1
  fi
  if [ -z "$DWIN_PROJECT_BASE" ] ; then
      echo "Variable DWIN_PROJECT_BASE is not set in ${FLAVOUR_PATH}/${FLAVOUR_CONFIG}."
      exit 1
  fi
  if [ -z "$RESOURCES_BASE" ] ; then
      echo "Variable RESOURCES_BASE is not set in ${FLAVOUR_PATH}/${FLAVOUR_CONFIG}."
      exit 1
  fi
}


function flavour_config_build_sanity_check()
{
  flavour_config_compile_sanity_check
  flavour_config_build_sanity_check
}


function print_config_info()
{
  echo "Configuration details"
  echo "CONFIGURATION:  $FLAVOUR_CONFIG"
  echo "FLAVOUR:        $FLAVOUR"
  echo "EXTUI:          $EXTUI"
  echo "HARDWARE:       $HARDWARE"
  echo "PROJECT BASE:   $DWIN_PROJECT_BASE"
  echo "RESOURCES BASE: $RESOURCES_BASE"
}


# replaced DWIN_SET folder on removable device and unmounts device
# $1 ... source: path containing DWIN_SET folder 
# $2 ... destination: path to mounted device
function copy_project_to_removable_disk()
{
  local source_path=$1
  local dwin_set="DWIN_SET"
  local source_path_dwin_set="${1}/${dwin_set}"
  local destination_path=$2

  #local usage="\
  #Usage: [ arg1 arg2 ]\n\
  #   arg1: source folder containing ./${dwin_set}/ (absolute path)\n\
  #   arg2: destination root folder to removable device (absolute path)\n\
  #"

  if [ ! -d "$source_path" ] ; then
    echo "Failed to locate source directory '$source_path'."
    echo -e $usage
    return 1
  fi

  if [ ! -d "$source_path_dwin_set" ] ; then
    echo "Failed to locate source directory '$source_path_dwin_set'."
    #echo -e $usage
    return 1
  fi
  
  if [ ! -d "$destination_path" ] ; then
    echo "Failed to locate removable device root directory '$destination_path'."
    #echo -e $usage
    return 1
  fi

  pushd $destination_path > /dev/null

  echo "Cleaning $dwin_set on removable device ($destination_path)" && rm -drf ./${dwin_set}/* \
  && echo -e "copy ${source_path_dwin_set} \n  -> $destination_path" && cp -dprf ${source_path_dwin_set} ./ \
  && echo "unmounting device '$destination_path'" && cd ../ && umount $destination_path && sync \
  && echo -e "successfully copied $source_path_dwin_set \n  -> $destination_path/${dwin_set}"

  popd > /dev/null
}
