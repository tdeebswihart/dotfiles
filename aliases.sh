alias timestamp='gawk "{now=strftime(\"%F %T \"); print now \$0; fflush(); }"'

# Aliasing one program to another
hash python3 && alias serve="python3 -m http.server 9494"
hash pry && alias irb=pry
hash hub && eval "$(hub alias -s)"


