#!/bin/bash

mkdir -p $BACKUP_DEST/archives
NOW=$(date +%Y%m%d%H%M%S)
if [ -d $BACKUP_DEST/snapshots ]
then
  tar -clf $BACKUP_DEST/archives/$NOW.tar.gz -C $BACKUP_DEST/snapshots . && rm -rf $BACKUP_DEST/snapshots && rm -f $BACKUP_DEST/current
else
  echo "ERROR: No snapshots available." 1>&2 # error message, so write to stderr
fi
