Installing:
    curl -L https://iterm2.com/misc/`basename $SHELL`_startup.in >> ~/.iterm2_shell_integration.`basename $SHELL`


Because I can't get APS to work I must do the following:

in `~/.zshrc` or some `~/.secret/iterm.sh`:
```
echo -e "\033]50;SetProfile=PROFILE_NAME"
```

in `~/.zlogout`:
```
if [ "$SHLVL" = 1 ]; then
  echo -e "\033]50;SetProfile=PROFILE_NAME\a"
  clear
fi
```
