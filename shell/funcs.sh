## VIM
# Set the name of vim session the terminal is tied up to
eset(){
    export VI_SERVER=$1
}

# Fire up a new server according to the argument supplied
vs(){
    eset $1
    vim --servername $VI_SERVER
}

# Open up the files in the environment Vim server.
es(){
    vim --servername $VI_SERVER --remote-silent $*
}

gpx2json() {
    while [ "$1" != "" ]; do
        ogr2ogr -f GeoJSON "${1}.json" "${1}" routes && shift
    done
}

# Reuse Vim ZSH completions for vim completions
compdef _vim es

eset zshsession
test -f ~/.local.sh && source ~/.local.sh
