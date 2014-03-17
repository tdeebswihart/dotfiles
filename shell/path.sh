case $(uname -s) in
Linux)
    BASEPATH="/usr/lib/lightdm/lightdm:/opt/metasploit-framework:/opt/metasploit-framework/tools:$PATH"
    export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.6/dist-packages"
    #hash clang && export CC=$(which clang)
    #hash clang++ && export CXX=$(which clang++)
    hash keychain && eval 'keychain --eval id_rsa'
    ;;
Darwin)
    BASEPATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/MacGPG2/bin:/usr/texbin"
    if [ -z "$JAVA_HOME" -a -d /System/Library/Frameworks/JavaVM.framework/Home ]; then
        export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
    fi

    # NPM for node
    if [[ -d "/usr/local/share/npm/bin" ]]; then
        BASEPATH="/usr/local/share/npm/bin:$BASEPATH"
    fi

    # ccache symlinks for compilers
    if [[ -d "$(brew --prefix ccache)/libexec" ]]; then
        BASEPATH="$(brew --prefix ccache)/libexec:$BASEPATH"
    fi
    # Fix for homebrew pkg-config
    export PKG_CONFIG_PATH="/usr/local/Library/ENV/pkgconfig/10.9"

    # GDAL data file locations
    export GDAL_DATA="$(brew --prefix gdal)/share/gdal"

    alias dutil="diskutil"
    ;;
esac

# Ruby via rbenv
# if [[ -d "$HOME/.rbenv" ]]; then
#     BASEPATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$BASEPATH"
# fi

# Python via pyenv
if [[ -d "$HOME/.pyenv" ]]; then
    BASEPATH="$HOME/.pyenv/shims:$BASEPATH"
fi

# Cabal binfiles
if [[ -d "$HOME/.cabal/bin" ]]; then
    BASEPATH="$HOME/.cabal/bin:$BASEPATH"
fi

#Setting path
PATH=$BASEPATH
export PATH
