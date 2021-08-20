#!/usr/bin/env bash

ROOT_UID=0
DEST_DIR=

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/icons"
else
  DEST_DIR="$HOME/.icons/"
  mkdir -p $DEST_DIR
fi

# Remove folder if existing
if [ -d "$DEST_DIR/Nordzy-cursors" ]; then
  rm -rf "$DEST_DIR/Nordzy-cursors"
fi
if [ -d "$DEST_DIR/Nordzy-white-cursors" ]; then
  rm -rf "$DEST_DIR/Nordzy-white-cursors"
fi

cp -r Nordzy-cursors/ $DEST_DIR/Nordzy-cursors
cp -r Nordzy-cursors-white/ $DEST_DIR/Nordzy-cursors-white

echo "Finished..."

