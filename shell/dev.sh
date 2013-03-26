export DEV=$HOME/Development

#GO exports
export MYGO=$DEV/mygo
export GOROOT="$DEV/go"
export GOBIN="$GOROOT/bin"
export GOPATH="$DEV/mygo"
#source $GOROOT/misc/zsh/go

export MAKEFLAGS='-j 4'
# ccache settings
export CCACHE_COMPRESS=""

# set up nock
export QUIVER="$DEV/quiver"
test -d "$QUIVER" && eval "$($QUIVER/bin/nock init -)"
