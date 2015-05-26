case $(uname -s) in
    Linux)
        # /usr/lib/lightdm/lightdm:
        BASEPATH="/usr/local/texlive/2014/bin/x86_64-linux:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
        hash keychain && eval 'keychain --eval id_rsa'
        alias md5='md5sum'
        ;;
    Darwin)
        # since /usr/local is managed by homebrew (and it complains about "unmanaged" pkgs, I use $HOME/.local
        BASEPATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/MacGPG2/bin:/usr/texbin"
        if [ -z "$JAVA_HOME" -a -d /System/Library/Frameworks/JavaVM.framework/Home ]; then
            export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
        fi

        # NPM for node
        if [[ -d "/usr/local/share/npm/bin" ]]; then
            BASEPATH="$BASEPATH:/usr/local/share/npm/bin"
        fi

        # haskell
        if [[ -d "$HOME/Library/Haskell/bin" ]]; then
            BASEPATH="$HOME/Library/Haskell/bin:$BASEPATH"
        fi

        # GDAL data file locations
        export GDAL_DATA="$(brew --prefix gdal)/share/gdal"

        alias dutil="diskutil"

        # OPAM configuration
        hash opam && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
esac

# Ruby via rbenv
#if [[ -d "$HOME/.rbenv" ]]; then
#     BASEPATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$BASEPATH"
#fi

# Cabal binfiles
if [[ -d "$HOME/.cabal/bin" ]]; then
    BASEPATH="$HOME/.cabal/bin:$BASEPATH"
fi

if [[ -d "$GOPATH/bin" ]]; then
    BASEPATH="$GOPATH/bin:$BASEPATH"
fi

#Setting path
PATH="$HOME/.local/bin:$BASEPATH"
export PATH
