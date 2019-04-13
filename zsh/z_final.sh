if [[ "$SHELL" == *zsh ]]; then
    setopt APPEND_HISTORY
    setopt SHARE_HISTORY
    setopt HIST_IGNORE_DUPS
fi

export HISTSIZE=1000
unset HISTFILE

zstyle ':completion:*' matcher-list '' 'r:|?=** m:{a-z\-}={A-Z\_}'

for i in `ls ~/.secret/*.sh`; do
    source $i
done

