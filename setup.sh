#!/bin/bash

python3 install.py config.json $*
# cask requires passwords sometimes
test -f /tmp/casks && xargs </tmp/casks brew cask install
