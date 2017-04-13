if [[ "$SHELL" == *zsh ]]; then
    setopt APPEND_HISTORY
    setopt SHARE_HISTORY
    setopt HIST_IGNORE_DUPS
fi

export HISTSIZE=1000

for i in `ls ~/.secret/*.sh`; do
    source $i
done

# Not sure why this is here.
# case $(uname -s) in
# Linux)
#     export _JAVA_AWT_WM_NONREPARENTING=1
#     ;;
# esac
