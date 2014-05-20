## VIM
# Set the name of vim session the terminal is tied up to
eset (){
    export VI_SERVER=$1
}

# Highlight code for use w/ keynote, etc
hilight () {
  if [ -z "$1" ]
    then src="pbpaste"
  else
    src="cat $1"
  fi
  # $src | highlight -O rtf --syntax $1 --font Inconsolata --style solarized-dark --font-size 24 | pbcopy
  $src | pygmentize -f rtf -O 'fontface=Inconsolata,style=tango'| sed 's;\\f0;\\f0\\fs60;g' | tr -d '\n' | sed 's;\\par}$;};' | pbcopy
}

prettymd (){
    pandoc -t markdown --atx-headers --no-wrap $*
}
gpx2json () {
    while [ "$1" != "" ]; do
        ogr2ogr -f GeoJSON "${1}.json" "${1}" routes && shift
    done
}

urlencode () {
    python -c "import sys, urllib as ul; print ul.quote_plus('$1')"
}

urldecode () {
    python -c "import sys, urllib as ul; print ul.unquote_plus('$1')"
}

function dict () {
    if [[ $1 == (d|m) ]]; then
        curl dict://dict.org/$1:$2 | $PAGER
    else
        echo 'Unknown command. Use (d)efine or (m)atch.'
    fi
}

# Reuse Vim ZSH completions for vim completions
if [[ "$SHELL" == *zsh ]]; then
    compdef _vim es
    eset zshsession
fi

test -f ~/.local.sh && source ~/.local.sh
