# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gallois"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias t="todo.sh"
export GOROOT="$HOME/dev/go"
export GOPATH=$HOME/dev/mygo
export MYGO=$HOME/dev/mygo
export GOBIN=$MYGO/bin

export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.6/dist-packages"
alias aga='sudo apt-get autoremove'
alias kn='keepnote 1>/dev/null 2>&1'
# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby bundler python)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/si-coop123-d01/.rbenv/shims:/home/si-coop123-d01/dev/go/bin:/home/si-coop123-d01/.rbenv/bin:/home/si-coop123-d01/bin:/usr/lib/lightdm/lightdm

PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/metasploit-framework:/opt/metasploit-framework/tools:$HOME/dev/go/bin:$GOBIN:$HOME/.rbenv/shims:$HOME/.rbenv/bin:/home/si-coop123-d01/bin

source ~/.funcs

source ~/.secret/vars.sh #secrets!
source ~/.exports
#export PATH="$HOME/dev/go/bin:$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

