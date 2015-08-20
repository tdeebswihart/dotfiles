
# fh - repeat history
fh() {
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# fkill - kill process
fkill() {
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]
    then
        kill -${1:-9} $pid
    fi
}


## Git

# fbr - checkout git branch (including remote branches)
fbr() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
        branch=$(echo "$branches" |
                        fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
fco() {
    local tags branches target
    tags=$(
        git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(
        git branch --all | grep -v HEAD             |
            sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
            sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$(
        (echo "$tags"; echo "$branches") |
            fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
    git checkout $(echo "$target" | awk '{print $2}')
}

# fshow - git commit browser
fshow() {
    local out sha q
    while out=$(
            git log --decorate=short --graph --oneline --color=always |
                fzf --ansi --multi --no-sort --reverse --query="$q" --print-query); do
        q=$(head -1 <<< "$out")
        while read sha; do
            [ -n "$sha" ] && git show --color=always $sha | less -R
        done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    done
}

vs(){
    #List all vagrant boxes available in the system including its status, and try to access the selected one via ssh
    cd $(cat ~/.vagrant.d/data/machine-index/index | jq '.machines[] | {name, vagrantfile_path, state}' | jq '.name + "," + .state  + "," + .vagrantfile_path'| sed 's/^"\(.*\)"$/\1/'| column -s, -t | sort -rk 2 | fzf | awk '{print $3}'); vagrant ssh
}
