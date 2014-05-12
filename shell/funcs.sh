## VIM
# Set the name of vim session the terminal is tied up to
eset(){
    export VI_SERVER=$1
}

# Highlight code for use w/ keynote, etc
hilight() {
  if [ -z "$1" ]
    then src="pbpaste"
  else
    src="cat $1"
  fi
  # $src | highlight -O rtf --syntax $1 --font Inconsolata --style solarized-dark --font-size 24 | pbcopy
  $src | pygmentize -f rtf -O 'fontface=Inconsolata,style=tango'| sed 's;\\f0;\\f0\\fs60;g' | tr -d '\n' | sed 's;\\par}$;};' | pbcopy
}

prettymd(){
    pandoc -t markdown --atx-headers --no-wrap $*
}

# Fire up a new server according to the argument supplied
vs(){
    eset $1
    vim --servername $VI_SERVER
}

# Open up the files in the environment Vim server.
es(){
    vim --servername $VI_SERVER --remote-silent $*
}

gpx2json() {
    while [ "$1" != "" ]; do
        ogr2ogr -f GeoJSON "${1}.json" "${1}" routes && shift
    done
}

# Reuse Vim ZSH completions for vim completions
compdef _vim es

eset zshsession
test -f ~/.local.sh && source ~/.local.sh
