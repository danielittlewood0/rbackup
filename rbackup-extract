#!/bin/bash

if [ -d $BACKUP_DEST/snapshots.restore ]; then
  echo "ERROR: Restore in progress. Try rbackup-clean snapshots.restore to continue." 1>&2 # error message, so write to stderr
elif [ -n "$1" ]; then
  mkdir -p $BACKUP_DEST/snapshots.restore
  tar -xvf $BACKUP_DEST/$1 -C $BACKUP_DEST/snapshots.restore && rm $BACKUP_DEST/$1
  rmdir $BACKUP_DEST/snapshots.restore --ignore-fail-on-non-empty # only cleans up if rsync failed
else
  echo "You must choose an archive to extract."
  cd $BACKUP_DEST
  if [ -d archives ]; then
    find archives -maxdepth 1 -mindepth 1
  fi
fi
