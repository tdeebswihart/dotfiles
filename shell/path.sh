case $(uname -s) in
    Linux)
        # /usr/lib/lightdm/lightdm:
        BASEPATH="$PATH"
        hash keychain && eval 'keychain --eval id_rsa'
        alias md5='md5sum'
        ;;
    Darwin)
        # since /usr/local is managed by homebrew (and it complains about "unmanaged" pkgs, I use $HOME/.local
        BASEPATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:"
        if [[ -d "/opt/X11/bin" ]]; then
          BASEPATH="$BASEPATH:/opt/X11/bin"
        fi
        if [[ -d "/usr/local/MacGPG2/bin" ]]; then
          PATH="$BASEPATH:/usr/local/MacGPG2/bin"
        fi
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

        if [[ -d "/Library/TeX/texbin" ]]; then
            # Fix for TeX on El Capitan
            BASEPATH="/Library/TeX/texbin:$BASEPATH"
        fi

        # GDAL data file locations
        export GDAL_DATA="$(brew --prefix gdal)/share/gdal"

        alias dutil="diskutil"

        # OPAM configuration
        hash opam &>/dev/null && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

        # Haskell, since the brew installed version has issues
        # Add GHC 7.8.4 to the PATH, via https://ghcformacosx.github.io/
        export GHC_DOT_APP="$HOME/Applications/ghc-7.8.4.app"
        if [ -d "$GHC_DOT_APP" ]; then
            BASEPATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${BASEPATH}"
        fi

        # iTerm 2.9+
        test -f "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

        # MacPorts
        if [[ -d "$HOME/macports/bin" ]]; then
          BASEPATH="$HOME/macports/bin:$BASEPATH"
        fi
        if [[ -d "$HOME/miniconda3/bin" ]]; then
          BASEPATH="$HOME/miniconda3/bin:$BASEPATH"
        fi
esac

# Cabal binfiles
if [[ -d "$HOME/.cabal/bin" ]]; then
    BASEPATH="$HOME/.cabal/bin:$BASEPATH"
fi

if [[ -d "$GOPATH/bin" ]]; then
    BASEPATH="$GOPATH/bin:$BASEPATH"
fi

if [[ -d "$HOME/.cargo/bin" ]]; then
    BASEPATH="$HOME/.cargo/bin:$BASEPATH"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#Setting path -- my local prefix comes first *always*
PATH="$HOME/.local/bin:$BASEPATH"
export PATH
