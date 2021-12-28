#!/bin/bash

if [ -d "$BACKUP_DEST/snapshots.restore" ]; then
  echo "ERROR: Restore in progress. Try rbackup <name> clean snapshots.restore to continue." 1>&2 # error message, so write to stderr
elif [ -n "$1" ]; then
  mkdir -p "$BACKUP_DEST/snapshots.restore"
  gpg --decrypt "$BACKUP_DEST/$1" |
    tar --extract --directory="$BACKUP_DEST/snapshots.restore" --gzip &&
    rm $BACKUP_DEST/$1
  rmdir "$BACKUP_DEST/snapshots.restore" --ignore-fail-on-non-empty # only cleans up if rsync failed
else
  echo "You must choose an archive to extract."
  cd "$BACKUP_DEST"
  if [ -d archives ]; then
    find archives -maxdepth 1 -mindepth 1
  fi
fi
