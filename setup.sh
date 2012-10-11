#!/bin/bash
# set up dotfiles
if [ uname -s == "Linux" ]; then
  export PLATFORM="Linux"
else
  export PLATFORM="Mac"
fi
for i in *;
do
  if [ "${i}" != "setup.sh" ]; then
    ln -sf $(pwd)/$i ../.$i
  fi
done
