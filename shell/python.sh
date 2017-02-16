export VIRTUAL_ENV_DISABLE_PROMPT=1
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
export WORKON_HOME="$HOME/.snakepit"
which virtualenvwrapper.sh >/dev/null 2>&1 && source $(which virtualenvwrapper.sh)
