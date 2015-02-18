# Antigen
source ~/.antigen.zsh

# Antigen Bundles
# Load the oh-my-zsh's library.
antigen use oh-my-zsh
# Bundles from the default repo declared above.
antigen bundles <<EOBUNDLES
pip
gem
python
ssh-agent

# Guess what to install when running an unknown command.
command-not-found

# Helper for extracting different types of archives.
extract
# Help working with version control systems.
svn
git

# nicoulaj's moar completion files for zsh
zsh-users/zsh-completions src

# ZSH port of Fish shell's history search feature.
zsh-users/zsh-history-substring-search

# Syntax highlighting bundle.
zsh-users/zsh-syntax-highlighting
EOBUNDLES


# Os specific plugins
if [[ $CURRENT_OS == 'OS X' ]]; then
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle osx
    antigen bundle sudo
elif [[ $CURRENT_OS == 'Linux' ]]; then
    if [[ $DISTRO == 'CentOS' ]]; then
        antigen bundle centos
    fi
elif [[ $CURRENT_OS == 'Cygwin' ]]; then
    antigen bundle cygwin
fi

antigen theme gallois
antigen apply
