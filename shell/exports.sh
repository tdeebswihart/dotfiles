export TODOTXT_DEFAULT_ACTION=pv
export HISTFILE="$HOME/.zshistory"
export HISTSIZE=10000

for i in `ls ~/.secret/*.sh`; do
    source $i
done