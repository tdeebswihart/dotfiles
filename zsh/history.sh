if [[ "$SHELL" == *zsh ]]; then
    setopt APPEND_HISTORY
    setopt SHARE_HISTORY
    setopt HIST_IGNORE_DUPS
fi

export HISTSIZE=1000
unset HISTFILE

if test -d "$HOME/.zsh-histdb"; then
  source "$HOME/.zsh-histdb/sqlite-history.zsh"
  export HISTDB_FILE="$HOME/.zsh-history.db"
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd  histdb-update-outcome
  alias h=histdb
fi
