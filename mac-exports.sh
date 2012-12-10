#mac shell exports
export DEV=$HOME/Development

export GOROOT=$DEV/go
export GOPATH=$DEV/mygo
export MYGO=$DEV/mygo
export GOBIN=$MYGO/bin
export DEFPATH=/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin
export PATH=/usr/local/bin:/usr/local/sbin:$DEFPATH:$GOBIN:$HOME/bin:/Users/chronon/.rbenv/shims
#export CC=/usr/bin/clang
#export CXX=/usr/bin/clang++

source $GOROOT/misc/zsh/go


#defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
#defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad \
#  Clicking -bool true

