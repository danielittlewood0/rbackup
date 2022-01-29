#!/bin/bash

mkdir -p "$BACKUP_DEST/archives"
NOW=$(date +%Y%m%d%H%M%S)

if [ -d "$BACKUP_DEST/snapshots" ]; then
  rm -f "$BACKUP_DEST/current" # if snapshot and archive run simultaneously then current existing will confuse it
  tar --remove-files --create --check-links --gzip --directory="$BACKUP_DEST/snapshots" . | 
    gpg --encrypt -r "$GPG_RECIPIENT" --output "$BACKUP_DEST/archives/$NOW.tar.gz.gpg"
else
  echo "ERROR: No snapshots available." 1>&2 # error message, so write to stderr
fi
