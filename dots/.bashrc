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
export ORGHOME='/Users/timods/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org'

complete -C /usr/local/bin/nomad nomad
source "$HOME/.cargo/env"
