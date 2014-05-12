hash trash 2>/dev/null && alias rm=trash
alias wifi="networksetup -setairportpower en0"
alias serve="python3 -mhttp.server"
alias timestamp='gawk "{now=strftime(\"%F %T \"); print now \$0; fflush(); }"'
alias jsonp='python -m json.tool'
alias mounted='mount | column -t '
alias sorry='sudo $(history -n -1) '
alias vimp='vim -p'
alias v='f -t -e vim -b viminfo'
alias ipy='ipython notebook'
alias py='python'
alias rb='ruby'
alias mountp='mount | column -t'
alias wekarun="java -Xmx1000M -jar ~/bin/weka/weka.jar"
alias lockme="xscreensaver-command -lock"
