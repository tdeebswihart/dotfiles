hash trash 2>/dev/null && alias rm=trash
alias serve="python3 -m http.server 9494"
alias timestamp='gawk "{now=strftime(\"%F %T \"); print now \$0; fflush(); }"'
