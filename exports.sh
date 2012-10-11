#!/bin/bash
#cross-platform shell exports
export TODOTXT_DEFAULT_ACTION=ls
export REALLY_GEM_UPDATE_SYSTEM=true
export GOROOT="$HOME/dev/go"
export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.6/dist-packages"

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

export EDITOR=gvim

source $GOROOT/misc/zsh/go

export vless='/usr/share/vim/vimcurrent/macros/less.sh'
export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
      vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
      -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
      -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""
alias ai="sudo apt-get install"
alias adu="sudo apt-get dist-upgrade"
alias ar="sudo apt-get remove"
alias ai="sudo apt-get install"
