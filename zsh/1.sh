# Do nothing if not interactive
[ -z "$PS1" ] && return

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
