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

b64 () {
    # Encode data to or decode data from Base64
    if (( $# < 2 )); then
        echo "usage: base64 encode|decode DATA"
    else
        case $1 in
        encode)
            python -c "import base64 as b; print b.b64encode('$2')"
            ;;
        decode)
            python -c "import base64 as b; print b.b64decode('$2')"
            ;;
        *)
            echo "usage: base64 encode|decode DATA"
            ;;
        esac
    fi
}

urlencode () {
    python -c "import sys, urllib as ul; print ul.quote_plus('$1')"
}

urldecode () {
    python -c "import sys, urllib as ul; print ul.unquote_plus('$1')"
}

function dict () {
    if [[ "$1" =~ (d|m) ]]; then
        curl -s dict://dict.org/$1:$2 | less
    else
        echo 'Unknown command. Use (d)efine or (m)atch.'
    fi
}

function serve () {
    # Manage a simple HTTP server
    #
    # Usage:
    # serve start|stop|restart [port]
    #
    local port="${2:-8000}"
    case $1 in
    "start")
    echo "starting http server"
    nohup python -m SimpleHTTPServer >| /tmp/nohup.out &
    open "http://localhost:${port}/"
    ;;
    "stop")
    echo "stopping http server"
    kill $(ps aux | grep "python -m SimpleHTTPServer" \
                  | grep -v grep \
                  | awk '{print $2}') > /dev/null
    ;;
    "restart")
    echo "restarting http server"
    kill $(ps aux | grep "python -m SimpleHTTPServer" \
                  | grep -v grep | awk '{print $2}') > /dev/null
    nohup python -m SimpleHTTPServer >| /tmp/nohup.out &
    ;;
    *)
    echo "need start|stop|restart"
    esac
}

# Reuse Vim ZSH completions for vim completions
if [[ "$SHELL" == *zsh ]]; then
    compdef _vim es
    eset zshsession
fi

test -f ~/.local.sh && source ~/.local.sh
