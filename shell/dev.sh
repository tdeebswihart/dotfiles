export DEV=$HOME/Development

#GO exports
if [ "" = "${ALREADY_GLIDING}" ]; then
    export GOPATH="$DEV/mygo"
fi
export GDTMPLS="$GOPATH/src/github.com/chronoslynx/godoc-tmpls"

export MAKEFLAGS='-j 4'
# ccache settings
export CCACHE_COMPRESS=1

# personal installation prefix
export PREFIX="$HOME/.local"
export XTARGET="i686-elf"
export CARGO_HOME="$HOME/.cargo"

which direnv >/dev/null && eval "$(direnv hook zsh)"
