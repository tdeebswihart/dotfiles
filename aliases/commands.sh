hash trash 2>/dev/null && alias rm=trash
alias wifi="networksetup -setairportpower en0"
alias timestamp='gawk "{now=strftime(\"%F %T \"); print now \$0; fflush(); }"'
alias jsonpy='python -m json.tool'
alias mounted='mount | column -t '
alias vimp='vim -p'
alias py='python'
alias ipy='ipython'
which ptpython >/dev/null 2>&1 && alias py='ptpython' && alias ipy='iptpython'
alias rb='ruby'
alias lockme="xscreensaver-command -lock"
alias disas='objdump -d -M intel'
alias scanb='scan-build --use-analyzer=$(which clang-3.5)'
alias latexmk='latexmk -pvc'
alias aplay='ansible-playbook playbook.yml -i inventory'
# Fix pyenv and homebrew *-config issues
which brew > /dev/null 2>&1 && alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"
