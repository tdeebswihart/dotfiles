if [[ "$SHELL" == *zsh ]]; then
    setopt APPEND_HISTORY
    setopt SHARE_HISTORY
    setopt HIST_IGNORE_DUPS
fi

export HISTSIZE=1000
unset HISTFILE

if test -d "$HOME/.zsh/zsh-autosuggestions"; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if test -d "$HOME/.zsh-histdb"; then
  export HISTDB_TABULATE_CMD=(sed -e $'s/\x1f/\t/g')
  export HISTDB_FILE="$HOME/.zsh-history.db"
  source "$HOME/.zsh-histdb/sqlite-history.zsh"
  export HISTDB_FILE="$HOME/.zsh-history.db"
  autoload -Uz add-zsh-hook
  alias h=histdb
 
  _zsh_autosuggest_strategy_histdb_top_here() {
    local query="select commands.argv from
history left join commands on history.command_id = commands.rowid
left join places on history.place_id = places.rowid
where places.dir LIKE '$(sql_escape $PWD)%'
and commands.argv LIKE '$(sql_escape $1)%'
group by commands.argv order by count(*) desc limit 1"
    suggestion=$(_histdb_query "$query")
}
 
  export ZSH_AUTOSUGGEST_STRATEGY=(histdb_top_here)
  source ~/.zsh-histdb/histdb-interactive.zsh
  bindkey '^r' _histdb-isearch

  if test -d "$HOME/.zsh/zsh-autosuggestions"; then
	  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

	  export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
  fi

fi
