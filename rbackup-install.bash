#!/bin/bash

for script in rbackup*
do
  ln -s $(realpath $script) "$HOME/bin/$script"
done
