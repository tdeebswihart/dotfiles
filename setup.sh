#!/bin/bash

quietly () {
	eval $* > /dev/null 2>&1
}

python3 install.py config.json $* || (echo "Setup failed!" && exit 1)
# cask requires passwords sometimes
test -f /tmp/casks && xargs </tmp/casks brew cask install
case $(uname -s) in
  Darwin)
    for plist in launchdaemons/*.plist; do
      daemon_path="/Library/LaunchDaemons/${plist#launchdaemons/}"
      sudo cp "./${plist}" "$daemon_path"
      quietly sudo launchctl stop "$daemon_path"
      quietly sudo launchctl unload "$daemon_path"
      sudo launchctl load "$daemon_path"
      sudo launchctl start "$daemon_path" || echo "Error loading ${plist}!"
    done
    # quietly which stubby-setdns-macos.sh && sudo stubby-setdns-macos.sh
    ;;
  *) # Linux setup
    ;;
esac
