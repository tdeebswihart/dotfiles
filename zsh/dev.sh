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

if [[ `uname` == Darwin ]]; then
    MAX_MEMORY_UNITS=KB
else
    MAX_MEMORY_UNITS=MB
fi

export TIMEFMT='%J   %U  user %S system %P cpu %*E total'$'\n'\
'avg shared (code):         %X KB'$'\n'\
'avg unshared (data/stack): %D KB'$'\n'\
'total (sum):               %K KB'$'\n'\
'max memory:                %M '$MAX_MEMORY_UNITS''$'\n'\
'page faults from disk:     %F'$'\n'\
'other page faults:         %R'
