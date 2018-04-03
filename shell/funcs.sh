
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
         https://api.pushover.net/1/messages.json > /dev/null
}
alias pushn=push_notify

push_status () {
    local retcode="$?"
    local title="Command"
    if [ $# -gt 0 ]; then
        title=$1
    fi
    if [ "$retcode" -eq "0" ]; then
        push_notify "$title" "Great success!"
    else
        push_notify "$title" "Failed! Exit status $retcode"
    fi
}

alias pushs=push_status

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
alias pushx=push_exec

push_try_n () {
  local n=0
  local m="$1"
  shift
  echo "Trying from $n to $m"
  for i in `seq 1 $m`; do
    echo "[TRIAL=$i]"
    ("$@") && n=$[$n+1]
  done;
  push_notify "Command" "$n / $m trials succeeded"
}
alias pusht=push_try_n

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
                FN="${FN}quote_plus"
                ;;
            decode)
                FN="${FN}unquote_plus"
                ;;
            *)
                echo $USAGE
                return
                ;;
        esac
        python -c "import sys, urllib.parse as ul; print(ul.$FN('$2'))"
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
    if python --version | grep 'Python 3' >/dev/null 2>&1; then
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
            kill $(ps aux | grep "$module" \
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
        IGNORE_FILES=($HOME/.gitignore ./.gitignore ./.rsyncignore)
        EXCLUDE_FROM=""
        ARGS=$*
        for f in ${IGNORE_FILES[@]}; do
          if [[ -e $f ]]; then
            EXCLUDE_FROM="$EXCLUDE_FROM --exclude-from=\"$f\" "
          fi
        done
        # I don't know why it doesn't work if I run it directly...
        bash -c "$(echo rsync -azhW $EXCLUDE_FROM $ARGS)"
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

# Project Management, utility functions.
# vagrant helper function. I'm tired of cd-ing and typing 'vagrant' everywhere
v() { (cd "${VAGRANT_DIR:-.}" && vagrant "$@") }

build() {
    if [ "${BUILDARGS}" ]; then
        (cd "${BUILDDIR:-.}" && "${BUILDCMD:-make}" "${BUILDARGS}" "$@")
    else
        (cd "${BUILDDIR:-.}" && "${BUILDCMD:-make}" "$@")
    fi
}

provision() {
    if [ "$PROVISIONARGS" ]; then
        (cd "${PROVISIONDIR:-.}" && "${PROVISIONCMD:-ansible-playbook}" "${PROVISIONARGS}" "$@")
    else
        (cd "${PROVISIONDIR:-.}" && "${PROVISIONCMD:-ansible-playbook}" "$@")
    fi
}

testit() {
    if [ "${TESTARGS}" ]; then
        (cd "${TESTDIR:-.}" && "${TESTCMD:-make}" "${TESTARGS}" "$@")
    else
        (cd "${TESTDIR:-.}" && "${TESTCMD:-make}" "$@")
    fi
}

f() {
  find -name '$1'
}

mkiter () {
  echo "$*" | tr " " "\n"
}

quietly () {
  eval $* >/dev/null 2>&1
}

alias iter=mkiter
alias stfu=quietly

test -f ~/.local.sh && source ~/.local.sh
