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

test -f ~/.local.sh && source ~/.local.sh
