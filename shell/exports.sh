export TODOTXT_DEFAULT_ACTION=pv

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS

export HISTFILE="$HOME/.zshistory"
export HISTSIZE=10000
export SAVEHIST=10000

for i in `ls ~/.secret/*.sh`; do
    source $i
done