hash trash 2>/dev/null && alias rm=trash
alias wifi="networksetup -setairportpower en0"
alias timestamp='gawk "{now=strftime(\"%F %T \"); print now \$0; fflush(); }"'
alias jsonpy='python -m json.tool'
alias mounted='mount | column -t '
alias sorry='sudo $(history -n -1) '
alias vimp='vim -p'
alias py='ptpython'
alias ipy='ptipython'
alias rb='ruby'
alias mountp='mount | column -t'
alias wekarun="java -Xmx1000M -jar ~/bin/weka/weka.jar"
alias lockme="xscreensaver-command -lock"
alias xo='xdg-open'
alias disas='objdump -d -M intel'
alias scanb='scan-build --use-analyzer=$(which clang-3.5)'
alias julia='/opt/homebrew-cask/Caskroom/julia/0.3.2/Julia-0.3.2.app/Contents/Resources/julia/bin/julia'
