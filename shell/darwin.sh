if $(uname -s) = "Darwin"; then
  #keep casks up to date the right way
  function witches-brew() {
    brew update && brew upgrade && brew cleanup && cask-upgrade && cask-retire && brew cask cleanup && brew doctor && brew cask doctor
  }

  #that's some old shit
  function __clean-cask {
    caskBasePath="/opt/homebrew-cask/Caskroom"
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
