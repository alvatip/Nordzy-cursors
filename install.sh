#!/usr/bin/env bash

ROOT_UID=0
DEST_DIR=

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/icons"
else
  DEST_DIR="$HOME/.icons/"
  if [ ! -d $DEST_DIR ]; then
    mkdir -p $DEST_DIR
  fi
fi

cd themes
for theme in *
do
  if [ -d "$DEST_DIR/$theme" ]; then
    rm -rf $DEST_DIR/$theme
  fi
  cp -r $theme $DEST_DIR
done
echo "Themes installed!"