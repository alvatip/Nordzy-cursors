#!/bin/bash

#
# Create windows cursor using clickgen
#

list="left_ptr help text crosshair not-allowed move ns-resize ew-resize nesw-resize nwse-resize pointing_hand pencil up-arrow right_ptr openhand dnd-move"

# Create folder
if [ -d ${1} ]
then
	rm -rf ${1}
	mkdir ${1}
fi

for cursor in ${list}
do
  case ${cursor} in
    "left_ptr" | "help")
      x=9
      y=7;;
    "text" | "crosshair" | "not-allowed" | "move" | *'-resize')
      x=46
      y=46;;
    "pointing_hand")
      x=28
      y=11;;
    "pencil")
      x=8
      y=81;;
    "up-arrow")
      x=46
      y=13;;
    "right_ptr")
      x=52
      y=9 ;;
    "openhand" | "dnd-move")
      x=40
      y=40 ;;
    *)
      error=True;;
  esac

  if [ -z ${error} ]
  then
    echo "Creates static cursor ${cursor}..."
    clickgen -s 32 --out-dir ${1}/ --hotspot ${x} ${y} --type windows pngs/96/${cursor}.png
  else
    echo "It looks like something went wrong..."
  fi
done