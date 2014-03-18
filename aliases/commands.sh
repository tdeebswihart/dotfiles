hash trash 2>/dev/null && alias rm=trash
alias wifi="networksetup -setairportpower en0"
alias serve="python3 -mhttp.server "
alias timestamp='gawk "{now=strftime(\"%F %T \"); print now \$0; fflush(); }" '
#alias h='heroku '
alias _='sudo '
alias jsonp='python -m json.tool '
alias mounted='mount | column -t '
alias asshole='echo You dont have to be rude, you know. && sleep 0.2 && sudo $(history -n -1) '
alias sorry='sudo $(history -n -1) '
alias vimp='vim -p'
alias v='f -t -e vim -b viminfo'
