test -f /etc/static/zshrc  && source /etc/static/zshrc
# Do nothing if not interactive
[ -z "$PS1" ] && return

hash trash 2>/dev/null && alias rm=trash

# personal installation prefix

if [[ ! -z "$(which starship)" ]]
then
    eval "$(starship init zsh)"
fi
# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi # added by Nix installer


