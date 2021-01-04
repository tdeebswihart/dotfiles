source /etc/static/zshrc
ZSH_DISABLE_COMPFIX=true
if ! source "${HOME}/.zgen/init.zsh"; then
    # Load zgen
    source "${HOME}/.zgen.zsh"
    echo "Creating a zgen save"
    zgen load hlissner/zsh-autopair
    #zgen load zsh-users/zsh-syntax-highlighting
    # Save it to an init script
    zgen save
fi
# Completions
fpath=(~/.zsh $fpath)

# load built files
source ~/.config/zsh/config.sh
# if [ -e /Users/timods/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/timods/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
