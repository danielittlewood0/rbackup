#!/bin/bash

mkdir -p "$BACKUP_DEST/archives"
NOW=$(date +%Y%m%d%H%M%S)
TAROPTS="--remove-files --create --check-links --gzip --directory=$BACKUP_DEST/snapshots"

if [ -d "$BACKUP_DEST/snapshots" ]; then
  rm -f "$BACKUP_DEST/current" # if snapshot and archive run simultaneously then current existing will confuse it
  if [ -n "$GPG_RECIPIENT" ]; then
    tar $TAROPTS . | 
      gpg --encrypt -r "$GPG_RECIPIENT" --output "$BACKUP_DEST/archives/$NOW.tar.gz.gpg"
  else
    tar $TAROPTS --file "$BACKUP_DEST/archives/$NOW.tar.gz" .
  fi
else
  echo "ERROR: No snapshots available." 1>&2 # error message, so write to stderr
fi
