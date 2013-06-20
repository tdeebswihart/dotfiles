newest () { ls -ltr | tail -$1 ; }
haste(){
    ( echo "% $@"; eval "$@" ) | \
        curl -F "$@=<-" $HASTE_SERVER/documents | \
        awk -F '"' "{print '$HASTE_SERVER/'\$4}"
}
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
