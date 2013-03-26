if [[ hash subl ]]; then
    export EDITOR=subl
    export SUDOEDITOR=subl
elif [[ hash vim ]]; then
    export EDITOR=vim
    export SUDOEDITOR=vim
else
    export EDITOR=vi
    export SUDOEDITOR=vi
fi
