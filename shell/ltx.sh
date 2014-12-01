export LTXPATH="$HOME/Library/texmf/tex/latex"
function _zsh_ltx {
    reply=($(ls -d $LTXPATH/*/ | rev | cut -d '/' -f2 | rev))
}

function _bash_ltx {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$(ls -d $LTXPATH/*/ | rev | cut -d '/' -f2 | rev)") -- $cur)
}

case $SHELL in
    *zsh)
        compctl -K _zsh_ltx x3-init
        compctl -K _zsh_ltx ltx
        ;;
    *bash)
        complete -F _bash_ltx x3-init
        complete -F _bash_ltx ltx
        ;;
esac
