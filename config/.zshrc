ZSH_DISABLE_COMPFIX=true
if ! source "${HOME}/.zgen/init.zsh"; then
    # Load zgen
    source "${HOME}/.zgen.zsh"
    echo "Creating a zgen save"

    zgen oh-my-zsh
    zgen load zsh-users/zsh-syntax-highlighting
    #zgen oh-my-zsh themes/agnoster
    # zgen load caiogondim/bullet-train-oh-my-zsh-theme bullet-train

    # Themes
    # zgen oh-my-zsh themes/theunraveler

    # Save it to an init script
    zgen save
fi
# BULLETTRAIN_TIME_SHOW=false
# BULLETTRAIN_RUBY_SHOW=false
# Completions
fpath=(~/.zsh $fpath)

# load fresh-built files
source ~/.config/zsh/config.sh