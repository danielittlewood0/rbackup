#!/bin/bash

if [[ ! -d $BACKUP_DEST/archives ]]; then
  echo "ERROR: No archives available." 1>&2 # error message, so write to stderr
elif [[ -z "$ARCHIVE_DEST" ]]; then
  echo "ERROR: No remote specified." 1>&2
else
  rsync -avzh --remove-source-files --progress $BACKUP_DEST/archives $ARCHIVE_DEST && rmdir $BACKUP_DEST/archives
fi
