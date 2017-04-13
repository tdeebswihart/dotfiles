if [[ "$SHELL" == *zsh ]]; then
    setopt APPEND_HISTORY
    setopt SHARE_HISTORY
    setopt HIST_IGNORE_DUPS
fi

export HISTFILE="$HOME/.zshistory"
export HISTSIZE=1000
export SAVEHIST=1000

for i in `ls ~/.secret/*.sh`; do
    source $i
done

case $(uname -s) in
Linux)
    export _JAVA_AWT_WM_NONREPARENTING=1
    ;;
esac
