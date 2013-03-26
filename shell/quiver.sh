export QUIVER="$DEV/quiver"
if [ -d "${QUIVER}" ]; then
    export PATH="${PATH}:${QUIVER}/bin"
    source "$QUIVER/libexec/../completions/nock.zsh"
    _nock_wrapper() {
        local command="$1"
        if [ "$#" -gt 0 ]; then
            shift
        fi

        case "$command" in
            shell)
                eval `nock "sh-$command" "$@"`;;
            *)
                command nock "$command" "$@";;
        esac
    }
    nock=_nock_wrapper
fi
