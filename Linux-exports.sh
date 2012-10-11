#Linux shell exports
export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/metasploit-framework:/opt/metasploit-framework/tools:$HOME/dev/go/bin:$GOBIN:$HOME/.rbenv/shims:$HOME/.rbenv/bin:/home/si-coop123-d01/bin
export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.6/dist-packages"

export TODOTXT_DEFAULT_ACTION=pv
export REALLY_GEM_UPDATE_SYSTEM=true
export GOROOT="$HOME/dev/go"

export GOROOT="$HOME/dev/go"
export GOPATH=$HOME/dev/mygo
export MYGO=$HOME/dev/mygo
export GOBIN=$MYGO/bin

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

export EDITOR=vim

source $GOROOT/misc/zsh/go

#sets PAGER to be vim
export vless='/usr/share/vim/vimcurrent/macros/less.sh'
export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
      vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
      -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
      -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""
alias ai="sudo apt-get install"
alias adu="sudo apt-get dist-upgrade"
alias ar="sudo apt-get remove"
alias ai="sudo apt-get install"

alias aga='sudo apt-get autoremove'
alias kn='keepnote 1>/dev/null 2>&1'

# Tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
export TERM=rxvt-unicode-256color
eval $(dircolors ~/dotfiles/dircolors-solarized/dircolors.ansi-dark)
