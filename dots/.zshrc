ZSH_DISABLE_COMPFIX=true
if ! source "${HOME}/.zgen/init.zsh"; then
    # Load zgen
    source "${HOME}/.zgen.zsh"
    echo "Creating a zgen save"

    #zgen oh-my-zsh
    #zgen load zsh-users/zsh-syntax-highlighting
    # Save it to an init script
    zgen save
fi
# Completions
fpath=(~/.zsh $fpath)

# load fresh-built files
source ~/.config/zsh/config.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

