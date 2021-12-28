#!/bin/bash

for script in rbackup* iniget
do
  ln -f $(realpath $script) "$HOME/bin/$script"
done
mkdir -p $(dirname ${CONFIG_FILE}) && touch "$CONFIG_FILE"
