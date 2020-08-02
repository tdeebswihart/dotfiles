if [ $(uname -s) = "Darwin" ]; then
  alias battery="pmset -g batt"
  function plugged_in () {
    return battery | grep 'AC Power' &>/dev/null
  }

  function unplugged () {
    return battery | grep 'Battery Power' &>/dev/null
  }

  #keep casks up to date the right way
  alias morningbrew='brew update && brew upgrade && brew cask upgrade && brew cleanup && cask-retire; brew doctor'

  #that's some old shit
  function __clean-cask {
    caskBasePath="/usr/local/Caskroom"
    local cask="$1"
    local caskDirectory="$caskBasePath/$cask"
    local versionsToRemove="$(ls -r $caskDirectory | sed 1,1d)"
    if [[ -n $versionsToRemove ]]; then
      while read versionToRemove ; do
        echo "Removing $cask $versionToRemove..."
        rm -rf "$caskDirectory/$versionToRemove"
      done <<< "$versionsToRemove"
    fi
  }

  #call this command to cleanup all, or you can specify cask name
  function cask-retire {
    if [[ $# -eq 0 ]]; then
      while read cask; do
        __clean-cask "$cask"
      done <<< "$(brew cask list)"
    else
      clean-cask "$1"
    fi
  }

  function watch_this () {
    if [[ -z "$1" ]]; then
      echo "usage: watch_this WATCHER_NAME"
      return 1
    fi
    if ! which watchman-process-files.py >/dev/null; then
      echo "error! watchman-process-files.py cannot be found!"
      return 1
    fi
    local name="$1"
    if [[ ! -z "$2" ]]; then
      local target="$2"
    else
      local target=$(pwd)
    fi
    watchman -- trigger \"${target}\" \"${name}\" -- python3 $(which watchman-process-files.py)
  }

  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


fi
