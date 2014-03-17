case `uname -s` in
Linux)
    PATHPREFIX="/usr/lib/lightdm/lightdm:/opt/metasploit-framework:/opt/metasploit-framework/tools"
    export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.6/dist-packages"
    if [[ -d "$HOME/.rbenv" ]]; then
        PATHPREFIX="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATHPREFIX"
    fi

    hash clang && export CC=$(which clang)
    hash clang++ && export CXX=$(which clang++)

    hash keychain && eval 'keychain --eval id_rsa'
    ;;
Darwin)
    if [ -z "$JAVA_HOME" -a -d /System/Library/Frameworks/JavaVM.framework/Home ]
    then
        export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home
    fi
    if [[ -d "$HOME/Library/Applcation Support/MATLAB/rvctools" ]]; then
        setenv MATLABPATH "$HOME/Library/Applcation Support/MATLAB/rvctools"
    fi

    ## Setting up path prefix
    PATHPREFIX="$HOME/bin"
    if [[ -d "/usr/local/share/npm/bin" ]]; then
        PATHPREFIX=$PATHPREFIX:"/usr/local/share/npm/bin"
    fi

    # Cabal binfiles
    if [[ -d "$HOME/.cabal/bin" ]]; then
        PATHPREFIX=$PATHPREFIX:$HOME/.cabal/bin
    fi

    # # Anaconda setup (for ipython)
    # if [[ -d "$HOME/anaconda/bin" ]]; then
    #     PATHPREFIX=$PATHPREFIX:$HOME/anaconda/bin
    # fi

    # ccache symlinks for compilers

    if [[ -d "$(brew --prefix ccache)/libexec" ]]; then
        PATHPREFIX=$PATHPREFIX:$(brew --prefix ccache)/libexec
    fi
    # Fix for homebrew pkg-config
    export PKG_CONFIG_PATH="/usr/local/Library/ENV/pkgconfig/10.9"

    # GDAL data file locations
    export GDAL_DATA="$(brew --prefix gdal)/share/gdal"

    alias dutil="diskutil"
    ;;
esac

#Setting path
PATH="$PATHPREFIX:/usr/local/sbin:/usr/local/bin:$PATH"
export PATH
