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
    local USAGE="usage: base64 encode|decode DATA"
    if (( $# < 2 )); then
        echo $USAGE
    else
        case $1 in
            encode|decode)
                python -c "import base64 as b; print b.b64$1('$2')"
                ;;
            *)
                echo $USAGE
                ;;
        esac
    fi
}

url () {
    local USAGE="usage: url encode|decode STRING"
    if (( $# < 2 )); then
        echo $USAGE
    else
        local FN=
        case $1 in
            encode)
                FN="quote_plus"
                ;;
            decode)
                FN="unquote_plus"
                ;;
            *)
                echo $USAGE
                return
                ;;
        esac
        python -c "import sys, urllib as ul; print ul.$FN('$2')"
    fi
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

#Quick CoPy
function qcp () {
    if [ $# -lt 2 ]; then
        echo "usage: qcp [rsync flags] source dest"
    else
        rsync -azhW $*
    fi
}

# Reuse Vim ZSH completions for vim completions
if [[ "$SHELL" == *zsh ]]; then
    compdef _vim es
    eset zshsession
fi

test -f ~/.local.sh && source ~/.local.sh
