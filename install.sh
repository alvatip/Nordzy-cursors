#!/usr/bin/env bash

ROOT_UID=0
DEST_DIR=
cursors_list="Nordzy-cursors Nordzy-cursors-white Nordzy-cursors-lefthand"

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/icons"
else
  DEST_DIR="$HOME/.icons/"
  mkdir -p $DEST_DIR
fi

# Remove folder if existing
clean(){
  if [ -d "$DEST_DIR/${1}" ]; then
    rm -rf "$DEST_DIR/${1}"
  fi
}

# Install cursors theme
install(){
  cp -r ${1}/ $DEST_DIR/${1}
  echo "${1} installed!"
}

for cursors_theme in ${cursors_list}
do
  clean ${cursors_theme}
  install ${cursors_theme}
done