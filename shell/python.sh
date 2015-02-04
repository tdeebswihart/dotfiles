export PYENV_ROOT="$HOME/.pyenv"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

[[ -f "/usr/local/opt/autoenv/activate.sh" ]] && source "/usr/local/opt/autoenv/activate.sh"


# if test -s "$(which virtualenv)"; then
#     export WORKON_HOME="$HOME/.snakepit"
#     if [[ -e '/usr/local/bin/virtualenvwrapper.sh' ]]; then
#         source '/usr/local/bin/virtualenvwrapper.sh'
#     fi
# fi
