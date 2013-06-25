case `uname -s` in
Linux)
    PATHPREFIX="/usr/lib/lightdm/lightdm:/opt/metasploit-framework:/opt/metasploit-framework/tools"
    #export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.6/dist-packages"
    if [[ -d "$HOME/.rbenv" ]]; then
        PATHPREFIX="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATHPREFIX"
    fi

    hash clang && export CC=/usr/bin/clang
    hash clang++ && export CXX=/usr/bin/clang++

    hash keychain && eval 'keychain --eval id_rsa'
    ;;
Darwin)
    ## set JAVA_HOME if on Mac OS
    if [ -z "$JAVA_HOME" -a -d /System/Library/Frameworks/JavaVM.framework/Home ]
    then
        export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home
    fi

    ## Setting up path prefix
    PATHPREFIX=""
    if [[ -d "$HOME/Applications/adt-bundle-mac-x86_64" ]]; then
        PATHPREFIX=$PATHPREFIX:"$HOME/Applications/adt-bundle-mac-x86_64/sdk/tools"
    fi
    if [[ -d "/usr/local/share/npm/bin" ]]; then
        PATHPREFIX="/usr/local/share/npm/bin"
    fi
    if [[ -d "/usr/local/heroku/bin" ]]; then
        PATHPREFIX=$PATHPREFIX:/usr/local/heroku/bin
    fi
    if [[ -d "/usr/local/share/python" ]]; then
        PATHPREFIX=$PATHPREFIX:/usr/local/share/python
    fi
    if [[ -d "$HOME/Library/Haskell/bin" ]]; then
        PATHPREFIX=$PATHPREFIX:/Users/chronon/Library/Haskell/bin
    fi
    if [[ -d "$HOME/.cabal/bin" ]]; then
        PATHPREFIX=$PATHPREFIX:/Users/chronon/.cabal/bin
    fi

    # Fix for homebrew pkg-config
    export PKG_CONFIG_PATH="/usr/local/Library/ENV/pkgconfig/10.8"

    ## CUDA
    PATHPREFIX=/Developer/NVIDIA/CUDA-5.0/bin:$PATHPREFIX
    #export DYLD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-5.0/lib:$DYLD_LIBRARY_PATH
    ;;
esac

#Setting path
PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATHPREFIX:$GOBIN:${GOPATH//://bin:}/bin:$PATH"
export PATH
