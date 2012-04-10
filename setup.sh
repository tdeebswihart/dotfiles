#!/bin/bash
# set up dotfiles
for i in *;
do
  if [ "${i}" != "setup.sh" ]; then
    ln -sf $i ../.$i
  fi
done
