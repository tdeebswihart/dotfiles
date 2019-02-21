__maybe_append () {
  # Add each argument to basepath (our first argument) if it exists
    test -z "$1" && echo ""
    local basepath="$1"
    shift
    while test ${#} -gt 0
    do
        local candidate="$1"
        if [[ -d "$candidate" ]]; then
          basepath="$candidate:$basepath"
        fi
        shift
    done
    echo "$basepath"
}

case $(uname -s) in
    Linux)
        # /usr/lib/lightdm/lightdm:
        BASEPATH="$PATH"
        #hash keychain && eval 'keychain --eval id_rsa'
        alias md5='md5sum'
        ;;
    Darwin)
        # since /usr/local is managed by homebrew (and it complains about "unmanaged" pkgs, I use $HOME/.local
        BASEPATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:"
        BASEPATH=$(__maybe_append "$BASEPATH" "/opt/X11/bin" "/Library/TeX/texbin" "$HOME/macports/bin")

        if [ -z "$JAVA_HOME" -a -d /System/Library/Frameworks/JavaVM.framework/Home ]; then
            export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
        fi

        # GDAL data file locations
        export GDAL_DATA="$(brew --prefix gdal)/share/gdal"

        alias dutil="diskutil"

        # OPAM configuration
        hash opam &>/dev/null && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

        # iTerm 2.9+
        test -f "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
        # racket bins
        for rkt in $(find -E $HOME/Library/Racket -type d -depth 1 -regex ".*/[0-9]+\.[0-9]+" | sort); do
          test -d "${rkt}/bin" && BASEPATH="${rkt}/bin:${BASEPATH}"
        done
esac

BASEPATH=$(__maybe_append "$BASEPATH" "$HOME/.cabal/bin" "$HOME/.cargo/bin" "$HOME/.nimble/bin")
if [[ ! -z "$GOPATH" ]]; then
    if [[ -d "$GOPATH/bin" ]]; then
        # Only add go it if GOPATH is nonempty
        BASEPATH="$GOPATH/bin:$BASEPATH"
    fi
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#Setting path -- my local prefix comes first *always*
PATH="$HOME/.local/bin:$BASEPATH"
export PATH
