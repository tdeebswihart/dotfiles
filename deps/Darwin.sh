# Install homebrew
if [ ! -d /usr/local/Cellar ]; then
  echo "Installing homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install homebrew packages
if [ -d "$(pwd)/extra/brew-leaves" ]; then
  echo "Installing homebrew packages"
  <"$(pwd)/extra/brew-leaves" xargs brew install
fi
