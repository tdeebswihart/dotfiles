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
export GOROOT="$HOME/dev/go"
export GOPATH=$HOME/dev/mygo

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
plugins=(git debian)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#export PATH=/home/si-coop123-d01/.rbenv/shims:/home/si-coop123-d01/dev/go/bin:/home/si-coop123-d01/.rbenv/bin:/home/si-coop123-d01/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

PATH=$HOME/dev/go/bin:/home/si-coop123-d01/.rbenv/shims:/home/si-coop123-d01/dev/go/bin:/home/si-coop123-d01/.rbenv/bin:/home/si-coop123-d01/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/metasploit-framework:/opt/metasploit-framework/tools:$HOME/dev/mygo/bin

source ~/.funcs

export GPGKEY=2AED6006
export MC_API_KEY=028bff7405c0f774c98810cbb8f6c00c-us4
#export PATH="$HOME/dev/go/bin:$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export mcserv=130.207.203.16

export REALLY_GEM_UPDATE_SYSTEM=true
export GOROOT="$HOME/dev/go"
export TSERV=128.61.67.215
export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.6/dist-packages"

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

source $GOROOT/misc/zsh/go
