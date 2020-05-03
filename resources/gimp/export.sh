#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# exports every layer that is a group to bmp

mkdir export
pushd "$SCRIPT_DIR/export"
gimp ../main.xcf -i -b - < ../gimp-export.sch 
popd
