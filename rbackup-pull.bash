#!/bin/bash

if [ -n "$1" ]; then
  mkdir -p $BACKUP_DEST/archives
  rsync -av $ARCHIVE_DEST/$1 $BACKUP_DEST/$1
  rmdir $BACKUP_DEST/archives --ignore-fail-on-non-empty # only cleans up if rsync failed
else
  echo "You must choose an archive to pull."
  rsync --list-only $ARCHIVE_DEST/archives
fi
