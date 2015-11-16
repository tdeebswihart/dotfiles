loginfo () {
    local prog="$1"
    shift 1
    echo "$@"
    logger -p user.notice -t "$prog" "$@"
}

logerr () {
    local prog="$1"
    shift 1
    echo "$@" >&2
    logger -p user.error -t "$prog" "$@"
}

# Send a push notification via pushover
push_notify () {
    local title=$1
    shift
    curl -s \
         -F "token=$PUSHOVER_TOK" \
         -F "user=$PUSHOVER_USER" \
         -F "title=$title" \
         -F "message=$*" \
         https://api.pushover.net/1/messages.json
}

# Execute the command defined by
push_exec () {
    local logf="$HOME/Library/Logs/push_exec.$RANDOM.log"
    loginfo push_exec "Executing and watching '$*'"
    ($@ 2>&1) > $logf
    if [ $? -eq 0 ] ; then
        # Success case
        local msg="succeeded on $(hostname): $* (in $(pwd))"
        loginfo 'push_exec' "$msg"
        push_notify "Command Succeeded" "$msg" >/dev/null
        rm "$logf" >/dev/null
    else
        # Error case
        local msg="exit $? on $(hostname): $* (in $(pwd))"
        logerr 'push_exec' "$msg"
        logerr 'push_exec' "Log can be found at $logf"
        push_notify "Command Failed" "$msg" >/dev/null
    fi
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
    local USAGE="usage: base64 encode|decode DATA"
    if (( $# < 2 )); then
        echo $USAGE
    else
        case $1 in
            encode|decode)
                python -c "import base64 as b; print(b.b64$1('$2'))"
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
    local module="SimpleHTTPServer"
    if python --version | grep 'Python 3' >/dev/null; then
        module='http.server'
    fi
    case $1 in
        "start")
            echo "starting http server"
            nohup python -m "$module" >| /tmp/nohup.out &
            open "http://localhost:${port}/"
            ;;
        "stop")
            echo "stopping http server"
            kill $(ps aux | grep "python -m $module" \
                          | grep -v grep \
                          | awk '{print $2}') > /dev/null
            ;;
        "restart")
            echo "restarting http server"
            kill $(ps aux | grep "python -m $module" \
                          | grep -v grep | awk '{print $2}') > /dev/null
            nohup python -m "$module" >| /tmp/nohup.out &
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

#setup terminal tab title
function title {
    if [ "$1" ]
    then
        unset PROMPT_COMMAND
        echo -ne "\033]0;${*}\007"
    else
        export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
    fi
}

title

# vagrant helper function. I'm tired of cd-ing and typing 'vagrant' everywhere
v() {
    (cd "${VAGRANT_DIR:-.}" && vagrant "$@")
}

test -f ~/.local.sh && source ~/.local.sh
