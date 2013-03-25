export DEV=$HOME/Development

case `uname -s` in
Linux)
    export PATHPREFIX="/usr/lib/lightdm/lightdm:/opt/metasploit-framework:/opt/metasploit-framework/tools"
    export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.6/dist-packages"

    hash clang && export CC=/usr/bin/clang
    hash clang++ && export CXX=/usr/bin/clang++
    alias kn='keepnote 1>/dev/null 2>&1'

    export EDITOR=vim
    export SUDOEDITOR=vim
    hash keychain && eval 'keychain --eval id_rsa'
    ;;
Darwin)
    # set JAVA_HOME if on Mac OS
    if [ -z "$JAVA_HOME" -a -d /System/Library/Frameworks/JavaVM.framework/Home ]
    then
        export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home
    fi

    # Setting up path prefix
    export PATHPREFIX=""
    if [[ -d "$HOME/Applications/adt-bundle-mac-x86_64" ]]; then
        export PATHPREFIX=$PATHPREFIX:"$HOME/Applications/adt-bundle-mac-x86_64/sdk/tools"
    fi
    if [[ -d "/usr/local/share/npm/bin" ]]; then
        export PATHPREFIX="/usr/local/share/npm/bin"
    fi
    if [[ -d "/usr/local/heroku/bin" ]]; then
        export PATHPREFIX=$PATHPREFIX:/usr/local/heroku/bin
    fi

    #CUDA
    export PATHPREFIX=/Developer/NVIDIA/CUDA-5.0/bin:$PATHPREFIX
    #export DYLD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-5.0/lib:$DYLD_LIBRARY_PATH
    export CCACHE_COMPRESS=""

    # load Homebrew's shell completion
    if which brew &> /dev/null && [ -f "$(brew --prefix)/Library/Contributions/brew_zsh_completion.sh" ]
    then
        source "$(brew --prefix)/Library/Contributions/brew_zsh_completion.sh"
    fi

    alias rm=trash
    alias make430="PATH=`brew --prefix llvm-msp430`/bin:$PATH make"
    alias mspmake="PATH=`brew --prefix llvm-msp430`/bin:$PATH make"

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
export MAKEFLAGS='-j 4'

#Setting path
export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATHPREFIX:$GOBIN:${GOPATH//://bin:}/bin:$PATH

# set up nock
export QUIVER="$HOME/.quiver"
test -d $QUIVER && eval "$($QUIVER/bin/nock init -)"

hash rbenv && eval "$(rbenv init - --no-rehash)"
test "$TMUX" && export TERM="screen-256color" # rxvt-unicode-256color
test -s $HOME/.tmuxinator/scripts/tmuxinator && source $HOME/.tmuxinator/scripts/tmuxinator
