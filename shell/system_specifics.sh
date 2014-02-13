case `uname -s` in
Linux)
    PATHPREFIX="/usr/lib/lightdm/lightdm:/opt/metasploit-framework:/opt/metasploit-framework/tools"
    export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.6/dist-packages"
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
    if [[ -d "$HOME/Library/Applcation Support/MATLAB/rvctools" ]]; then
        setenv MATLABPATH "$HOME/Library/Applcation Support/MATLAB/rvctools"
    fi

    ## Setting up path prefix
    PATHPREFIX=""
    if [[ -d "$HOME/Applications/adt-bundle-mac-x86_64" ]]; then
        PATHPREFIX=$PATHPREFIX:"$HOME/Applications/adt-bundle-mac-x86_64/sdk/tools"
        PATHPREFIX=$PATHPREFIX:"$HOME/Applications/adt-bundle-mac-x86_64/sdk/platform-tools"
    fi

    if [[ -d "/usr/local/share/npm/bin" ]]; then
        PATHPREFIX=$PATHPREFIX:"/usr/local/share/npm/bin"
    fi

    if [[ -d "/usr/local/heroku/bin" ]]; then
        PATHPREFIX=$PATHPREFIX:/usr/local/heroku/bin
    fi

    if [[ -d "$HOME/Library/Haskell/bin" ]]; then
        PATHPREFIX=$PATHPREFIX:$HOME/Library/Haskell/bin
    fi

    if [[ -d "$HOME/.cabal/bin" ]]; then
        PATHPREFIX=$PATHPREFIX:$HOME/.cabal/bin
    fi

    if [[ -d "$HOME/.pyenv/shims" ]]; then
        PATHPREFIX=$PATHPREFIX:$HOME/.pyenv/shims:
    fi
    # Fix for homebrew pkg-config
    export PKG_CONFIG_PATH="/usr/local/Library/ENV/pkgconfig/10.9"

    alias dutil="diskutil"

    ;;
esac

#Setting path
PATH="$HOME/bin$PATHPREFIX:/usr/local/sbin:/usr/local/bin:$GOBIN:${GOPATH//://bin:}/bin:$PATH"
export PATH
