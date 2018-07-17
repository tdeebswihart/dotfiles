if test -d "$HOME/.zsh-histdb"; then
  source "$HOME/.zsh-histdb/sqlite-history.zsh"
  export HISTDB_FILE="$HOME/.zsh-history.db"
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd  histdb-update-outcome
fi
