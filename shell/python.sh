export PYENV_ROOT="$HOME/.pyenv"

test -d $PYENV_ROOT/plugins/pyenv-virtualenv && eval "$($PYENV_ROOT/bin/pyenv virtualenv-init -)"

[[ -f "/usr/local/opt/autoenv/activate.sh" ]] && source "/usr/local/opt/autoenv/activate.sh"
