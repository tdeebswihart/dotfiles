# Do nothing if not interactive
[ -z "$PS1" ] && return
test -d "$HOME/homebrew/bin" && export PATH="$HOME/homebrew/sbin:$HOME/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

#Replaces ... -> ../.. on the fly
function rationalise-dot {
    if [[ $LBUFFER = *..  ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
