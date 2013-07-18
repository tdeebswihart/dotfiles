newest () { ls -ltr | tail -$1 ; }
hasteit() {
    case $(uname -s) in
    Darwin)
        cat $1 | haste | pbcopy
        ;;
    Linux)
        cat $1 | haste | xsel
        ;;
    esac
}

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

# Reuse Vim ZSH completions for vim completions
compdef _vim es

eset zshsession
test -f ~/.local.sh && source ~/.local.sh
