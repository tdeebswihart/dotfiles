#!/bin/bash

python install.py config.json $*
# cask requires passwords sometimes
xargs </tmp/casks brew cask install
