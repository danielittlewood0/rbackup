#!/bin/bash

mkdir -p $BACKUP_DEST/snapshots
NOW=$(date +%Y%m%d%H%M%S)

OPTS="-a --compress"
OPTS="$OPTS -xx" # avoid backing up mount points
OPTS="$OPTS -hvP" # if debugging
OPTS="$OPTS --exclude $BACKUP_DEST" # Do not backup your backups
EXCLUDES=(*/node_modules .cache cache* Cache* tmp /.rbenv /.npm Trash .config/chromium/Default/IndexedDB .local/var/pmbootstrap .local/share/godot)
for pattern in ${EXCLUDES[@]}
do
  OPTS="$OPTS --exclude $pattern"
done

CURRENT_LINK="$BACKUP_DEST/current"
LATEST_SNAPSHOT="$(readlink $CURRENT_LINK)"
NEW_SNAPSHOT="$BACKUP_DEST/snapshots/$NOW"
OPTS="${OPTS} --hard-links --link-dest=$LATEST_SNAPSHOT"

rsync $OPTS -- $BACKUP_SRC/ $NEW_SNAPSHOT && ln -snf $NEW_SNAPSHOT $CURRENT_LINK
