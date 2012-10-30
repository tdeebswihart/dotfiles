#Linux shell exports
export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/metasploit-framework:/opt/metasploit-framework/tools:$HOME/dev/go/bin:$GOBIN:$HOME/.rbenv/shims:$HOME/.rbenv/bin:/home/si-coop123-d01/bin
export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.6/dist-packages"

alias t='todo.sh'

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
eval 'keychain --eval id_rsa id_ecdsa'
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
alias v='f -e vim' # quick opening files with vim
alias m='f -e mplayer' # quick opening files with mplayer
alias o='a -e xdg-open' # quick opening files with xdg-open
