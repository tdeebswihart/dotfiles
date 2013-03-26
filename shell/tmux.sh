test "$TMUX" && export TERM="screen-256color" # rxvt-unicode-256color
test -s $HOME/.tmuxinator/scripts/tmuxinator && source $HOME/.tmuxinator/scripts/tmuxinator
