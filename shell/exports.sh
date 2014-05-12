export TODOTXT_DEFAULT_ACTION=pv

which setopt && setopt APPEND_HISTORY
which setopt && setopt SHARE_HISTORY
which setopt && setopt HIST_IGNORE_DUPS

export HISTFILE="$HOME/.zshistory"
export HISTSIZE=10000
export SAVEHIST=10000

for i in `ls ~/.secret/*.sh`; do
    source $i
done
