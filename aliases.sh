alias serve="python3 -m http.server 9494"
alias irb=pry
alias rm=trash
alias make430="PATH=`brew --prefix llvm-msp430`/bin:$PATH make"
alias mspmake="PATH=`brew --prefix llvm-msp430`/bin:$PATH make"
alias timestamp='gawk "{now=strftime(\"%F %T \"); print now \$0; fflush(); }"'

#eval "$(hub alias -s)"
