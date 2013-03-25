case `uname` in
Linux)
    export DEV=$HOME/dev
    export PATHPREFIX="/usr/lib/lightdm/lightdm:/opt/metasploit-framework:/opt/metasploit-framework/tools"
    export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.6/dist-packages"

    export CC=/usr/bin/clang
    export CXX=/usr/bin/clang++
    alias kn='keepnote 1>/dev/null 2>&1'

    export EDITOR=vim
    export SUDOEDITOR=vim
    #eval $(dircolors ~/dotfiles/dircolors-solarized/dircolors.ansi-dark)
    hash keychain && eval 'keychain --eval id_rsa'
    ;;
Darwin)
    export DEV=$HOME/Development
    #defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    #defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
    #defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad \
    #  Clicking -bool true
    export ANDPATH="$HOME/Applications/adt-bundle-mac-x86_64/sdk/tools"
    export PATHPREFIX="$ANDPATH:/usr/local/heroku/bin:$PATH:/usr/local/share/npm/bin:/opt/theos/bin"
    #CUDA
    export PATH=/Developer/NVIDIA/CUDA-5.0/bin:$PATH
    #export DYLD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-5.0/lib:$DYLD_LIBRARY_PATH
    export CCACHE_COMPRESS=""

    export EDITOR=subl
    export SUDO_EDITOR=subl
    ;;
esac

export TODOTXT_DEFAULT_ACTION=pv
export REALLY_GEM_UPDATE_SYSTEM=true

#GO exports
export MYGO=$DEV/mygo
export GOROOT="$DEV/go"
export GOBIN="$GOROOT/bin"
export GOPATH="$DEV/mygo"
#source $GOROOT/misc/zsh/go

#Setting path
export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATHPREFIX:$GOBIN:${GOPATH//://bin:}/bin:$PATH

hash rbenv && eval "$(rbenv init -)"
test "$TMUX" && export TERM="screen-256color" # rxvt-unicode-256color
test -s $HOME/.tmuxinator/scripts/tmuxinator && source $HOME/.tmuxinator/scripts/tmuxinator
