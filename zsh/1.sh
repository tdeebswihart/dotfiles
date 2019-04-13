# Do nothing if not interactive
[ -z "$PS1" ] && return
test -d "$HOME/homebrew/bin" && export PATH="$HOME/homebrew/sbin:$HOME/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

