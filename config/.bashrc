if [ -z "$PS1" ]; then
    return;
fi

# Path to the bash it configuration
if [ -d "$HOME/.bash_it" ]; then
  export BASH_IT=$HOME/.bash_it

  # Lock and Load a custom theme file
  # location /.bash_it/themes/
  export BASH_IT_THEME='minimal'

  # Load Bash It
  source $BASH_IT/bash_it.sh
fi
source ~/.fresh/build/shell.sh