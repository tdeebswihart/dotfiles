case $(uname -s) in
Linux)
    # /usr/lib/lightdm/lightdm:
    BASEPATH="~/dev/tools/metasploit-framework:/dev/tools/metasploit-framework/tools:$PATH"
    hash keychain && eval 'keychain --eval id_rsa'
    BASEPATH="/usr/local/texlive/2014/bin/x86_64-linux:$BASEPATH"
    alias md5='md5sum'
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

    # haskell
    if [[ -d "$HOME/Library/Haskell/bin" ]]; then
        BASEPATH="$HOME/Library/Haskell/bin:$BASEPATH"
    fi

    # clang tools
    if [[ -d "/usr/local/share/clang-3.5/tools/scan-build" ]]; then
        BASEPATH="/usr/local/share/clang-3.5/tools/scan-build:$BASEPATH"
    fi
    if [[ -d "/usr/local/share/clang-3.5/tools/scan-view" ]]; then
        BASEPATH="/usr/local/share/clang-3.5/tools/scan-view:$BASEPATH"
    fi
    # Fix for homebrew pkg-config
    #export PKG_CONFIG_PATH="/usr/local/Library/ENV/pkgconfig/10.9"

    # GDAL data file locations
    export GDAL_DATA="$(brew --prefix gdal)/share/gdal"

    alias dutil="diskutil"

    # OPAM configuration
    hash opam && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

    # ipython
    if [[ -f "/Users/chronon/.pyenv/versions/anaconda-1.9.1/bin/ipython" ]]; then
        alias ipython="/Users/chronon/.pyenv/versions/anaconda-1.9.1/bin/ipython"
    fi

    # Nim
    if [[ -d "/Users/chronon/Development/nim/Nim/bin" ]]; then
        BASEPATH="$BASEPATH:/Users/chronon/Development/nim/Nim/bin"
    fi
    ;;
esac

# Ruby via rbenv
# if [[ -d "$HOME/.rbenv" ]]; then
#     BASEPATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$BASEPATH"
# fi

# Python via pyenv
if [[ -d "$HOME/.pyenv" ]]; then
    BASEPATH="$BASEPATH:$HOME/.pyenv/bin"
    BASEPATH="$HOME/.pyenv/shims:$BASEPATH"
fi

# Cabal binfiles
if [[ -d "$HOME/.cabal/bin" ]]; then
    BASEPATH="$HOME/.cabal/bin:$BASEPATH"
fi

if [[ -d "$HOME/Development/mygo/bin" ]]; then
    BASEPATH="$HOME/Development/mygo/bin:$BASEPATH"
fi

#Setting path
PATH=$BASEPATH
export PATH
