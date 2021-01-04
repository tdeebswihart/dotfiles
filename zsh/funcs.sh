#!/bin/bash
#Quick CoPy
function qcp () {
    if [ $# -lt 2 ]; then
        echo "usage: qcp [rsync flags] source dest"
    else
        IGNORE_FILES=("$HOME/.gitignore" ./.gitignore ./.rsyncignore)
        EXCLUDE_FROM=""
        ARGS=$*
        for f in "${IGNORE_FILES[@]}"; do
          if [[ -e $f ]]; then
            EXCLUDE_FROM="$EXCLUDE_FROM --exclude-from=\"$f\" "
          fi
        done
        # I don't know why it doesn't work if I run it directly...
        bash -c "$(echo rsync -azhW $EXCLUDE_FROM $ARGS)"
    fi
}

#setup terminal tab title
function title {
    if [ "$1" ]
    then
        unset PROMPT_COMMAND
        echo -ne "\033]0;${*}\007"
    else
        export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
    fi
}

iter () {
  printf "%s\n" $@
}

quietly () {
  eval $* >/dev/null 2>&1
}

test -f ~/.local.sh && source ~/.local.sh
