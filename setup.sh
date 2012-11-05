#!/bin/bash
# set up dotfiles
if [ $(uname -s) == "Darwin" ]; then
  IGNORE="linux"
elif [ $(uname -s) == "Linux" ]; then
  IGNORE="mac"
fi
for i in *;
do
  if [ "${i}" != "setup.sh" ]; then
    echo $i
    #ln -sf $(pwd)/$i ../.$i
  fi
done
