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
