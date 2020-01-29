export DEV=$HOME/Development

#GO exports
if [ "" = "${ALREADY_GLIDING}" ]; then
    export GOPATH="$DEV/mygo"
fi
export GDTMPLS="$GOPATH/src/github.com/chronoslynx/godoc-tmpls"

# ccache settings
export CCACHE_COMPRESS=1

# personal installation prefix
export INSTALL_PREFIX="$HOME/.local"
export XTARGET="i686-elf"
export CARGO_HOME="$HOME/.cargo"
export CHOOSENIM_NO_ANALYTICS=1
export DESTDIR="$HOME/.local"
which direnv >/dev/null && eval "$(direnv hook zsh)"
