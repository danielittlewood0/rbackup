#!/bin/bash

if [ -d $BACKUP_DEST/archives ]
then
  rsync -avzh --remove-source-files --progress $BACKUP_DEST/archives $ARCHIVE_DEST && rmdir $BACKUP_DEST/archives
else
  echo "ERROR: No archives available." 1>&2 # error message, so write to stderr
fi

