#Linux shell exports
export PATH=$PATH:$GOBIN:$HOME/bin:$HOME/.rbenv/shims
export TODOTXT_DEFAULT_ACTION=pv
export REALLY_GEM_UPDATE_SYSTEM=true
export GOROOT="$HOME/dev/go"

export GOROOT="$HOME/Development/go"
export GOPATH=$HOME/Development/mygo
export MYGO=$HOME/Development/mygo
export GOBIN=$MYGO/bin

#export CC=/usr/bin/clang
#export CXX=/usr/bin/clang++

export EDITOR=vim

source $GOROOT/misc/zsh/go

#sets PAGER to be vim

# Tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad \
  Clicking -bool true

