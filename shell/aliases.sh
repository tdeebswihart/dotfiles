alias timestamp='gawk "{now=strftime(\"%F %T \"); print now \$0; fflush(); }"'

# Aliasing one program to another
alias serve="python3 -m http.server 9494"
alias irb=pry
hash hub && eval "$(hub alias -s)"


