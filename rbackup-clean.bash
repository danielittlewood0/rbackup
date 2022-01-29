#!/bin/bash

read -r -p "This will delete everything in $BACKUP_DEST/$1. Are you sure? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
      rm -rf "$BACKUP_DEST/$1"
        ;;
esac
