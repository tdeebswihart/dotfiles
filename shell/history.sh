if test -d "$HOME/.zsh-histdb"; then
  source "$HOME/.zsh-histdb/sqlite-history.zsh"
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd  histdb-update-outcome
fi
