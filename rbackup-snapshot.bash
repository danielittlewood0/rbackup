#!/bin/bash

mkdir -p $BACKUP_DEST/snapshots
NOW=$(date +%Y%m%d%H%M%S)

OPTS="-a --compress"
OPTS="$OPTS -xx" # avoid backing up mount points
OPTS="$OPTS -hvP" # if debugging

for pattern in ${EXCLUDES[@]}; do
  OPTS="$OPTS --exclude $pattern"
done

CURRENT_LINK="$BACKUP_DEST/current"
LATEST_SNAPSHOT="$(readlink $CURRENT_LINK)"
NEW_SNAPSHOT="$BACKUP_DEST/snapshots/$NOW"
OPTS="${OPTS} --hard-links --link-dest=$LATEST_SNAPSHOT"

rsync $OPTS -- $BACKUP_SRC/ $NEW_SNAPSHOT && ln -snf $NEW_SNAPSHOT $CURRENT_LINK
