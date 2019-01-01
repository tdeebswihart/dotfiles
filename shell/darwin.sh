if [ $(uname -s) = "Darwin" ]; then
  alias battery="pmset -g batt"
  function plugged_in () {
    return battery | grep 'AC Power' &>/dev/null
  }

  function unplugged () {
    return battery | grep 'Battery Power' &>/dev/null
  }
  #keep casks up to date the right way
  alias morningbrew='brew update && brew upgrade && brew cu && brew cleanup && cask-retire; brew doctor'

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
fi
