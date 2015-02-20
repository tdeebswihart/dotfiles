export PYENV_ROOT="$HOME/.pyenv"
if test -f $PYENV_ROOT/bin/pyenv; then
    eval "$($PYENV_ROOT/bin/pyenv init -)"
elif $(which pyenv 2>/dev/null); then
    eval "$(pyenv init -)"
fi
test -d $PYENV_ROOT/plugins/pyenv-virtualenv && eval "$($PYENV_ROOT/bin/pyenv virtualenv-init -)"

[[ -f "/usr/local/opt/autoenv/activate.sh" ]] && source "/usr/local/opt/autoenv/activate.sh"


# if test -s "$(which virtualenv)"; then
#     export WORKON_HOME="$HOME/.snakepit"
#     if [[ -e '/usr/local/bin/virtualenvwrapper.sh' ]]; then
#         source '/usr/local/bin/virtualenvwrapper.sh'
#     fi
# fi
