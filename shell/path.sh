case `uname -s` in
Linux)
    export PATHPREFIX="/usr/lib/lightdm/lightdm:/opt/metasploit-framework:/opt/metasploit-framework/tools"
    export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.6/dist-packages"
    if [[ -d "$HOME/.rbenv" ]]; then
        export PATHPREFIX="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATHPREFIX"
    fi

    hash clang && export CC=/usr/bin/clang
    hash clang++ && export CXX=/usr/bin/clang++
    alias kn='keepnote 1>/dev/null 2>&1'

    export EDITOR=vim
    export SUDOEDITOR=vim
    hash keychain && eval 'keychain --eval id_rsa'
    ;;
Darwin)
    ## set JAVA_HOME if on Mac OS
    if [ -z "$JAVA_HOME" -a -d /System/Library/Frameworks/JavaVM.framework/Home ]
    then
        export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home
    fi

    ## Setting up path prefix
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
    if [[ -d "/usr/local/share/python" ]]; then
        export PATHPREFIX=$PATHPREFIX:/usr/local/share/python
    fi
    if [[ -d "$HOME/Library/Haskell/bin" ]]; then
        export PATHPREFIX=$PATHPREFIX:/Users/chronon/Library/Haskell/bin
    fi
    if [[ -d "$HOME/.cabal/bin" ]]; then
        export PATHPREFIX=$PATHPREFIX:/Users/chronon/.cabal/bin
    fi

    ## CUDA
    export PATHPREFIX=/Developer/NVIDIA/CUDA-5.0/bin:$PATHPREFIX
    #export DYLD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-5.0/lib:$DYLD_LIBRARY_PATH


    ;;
esac

#Setting path
export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATHPREFIX:$GOBIN:${GOPATH//://bin:}/bin:$PATH"
