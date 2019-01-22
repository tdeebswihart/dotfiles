export REALLY_GEM_UPDATE_SYSTEM=true
if $(which rbenv 2>&1 >/dev/null); then
    eval "$(rbenv init -)"
fi
[[ -d $HOME/.rbenv/bin ]] && eval "$($HOME/.rbenv/bin/rbenv init - --no-rehash)"
[[ -s /usr/local/bin/rbenv ]] && eval "$(rbenv init - --no-rehash)"
alias bn='bundle'
alias bnx='bundle exec'
alias bni='bundle install'
