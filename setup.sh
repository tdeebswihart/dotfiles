#!/bin/bash
# set up dotfiles
for i in *;
do
  if [ "${i}" != "setup.sh" ]; then
    ln -s $i ../.$i
  fi
done
