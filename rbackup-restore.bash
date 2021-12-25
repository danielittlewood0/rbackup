#!/bin/bash

OPTS="-a --compress --hard-links"
OPTS="$OPTS -xx" # avoid backing up mount points
OPTS="$OPTS -hvP" # if debugging

if [ -n "$1" ]
then
  rsync $OPTS -- $BACKUP_DEST/$1/ $BACKUP_SRC
else
  echo "You must choose a snapshot to restore."
  cd $BACKUP_DEST
  if [ -d snapshots.restore ]; then
    find snapshots.restore -maxdepth 1 -mindepth 1
  fi
  if [ -d snapshots ]; then
    find snapshots -maxdepth 1 -mindepth 1
  fi
fi
