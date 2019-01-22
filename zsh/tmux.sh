test "$TMUX" && export TERM="screen-256color" # rxvt-unicode-256color
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
export DISABLE_AUTO_TITLE="true"
if which tmux >/dev/null 2>&1; then
  alias tat='tmux attach -t'
  alias tne='tmux new -s'
  alias tnew='tmux new -s'
  alias tls='tmux list-sessions'
  alias tls='tmux list-sessions'
  alias tks='tmux kill-session -t'
  alias tmv='tmux rename-session -t'
fi
