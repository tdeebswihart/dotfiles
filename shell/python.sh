if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if test -s "$(which virtualenv)"; then
    export WORKON_HOME="$HOME/.snakepit"
    if [[ -e '/usr/local/bin/virtualenvwrapper.sh' ]]; then
        source '/usr/local/bin/virtualenvwrapper.sh'
    fi
fi