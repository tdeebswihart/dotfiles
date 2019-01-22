alias ghc-sandbox="ghc -no-user-package-db -package-db .cabal-sandbox/*-packages.conf.d"
alias ghci-sandbox="ghci -no-user-package-db -package-db .cabal-sandbox/*-packages.conf.d"
alias runhaskell-sandbox="runhaskell -no-user-package-db -package-db .cabal-sandbox/*-packages.conf.d"

# unregister broken GHC packages. Run this a few times to resolve dependency rot in installed packages.
# ghc-pkg-clean -f cabal/dev/packages*.conf also works.
function ghc-pkg-clean() {
    for p in `ghc-pkg check $* 2>&1  | grep problems | awk '{print $6}' | sed -e 's/:$//'`
    do
        echo unregistering $p; ghc-pkg $* unregister $p
    done
}

# remove all installed GHC/cabal packages, leaving ~/.cabal binaries and docs in place.
# When all else fails, use this to get out of dependency hell and start over.
function ghc-pkg-reset() {
    if [[ $(readlink -f /proc/$$/exe) =~ zsh ]]; then
        read 'ans?Erasing all your user ghc and cabal packages - are you sure (y/N)? '
    else # assume bash/bash compatible otherwise
        read -p 'Erasing all your user ghc and cabal packages - are you sure (y/N)? ' ans
    fi

    [[ x$ans =~ "xy" ]] && ( \
        echo 'erasing directories under ~/.ghc'; command rm -rf `find ~/.ghc/* -maxdepth 1 -type d`; \
        echo 'erasing ~/.cabal/lib'; command rm -rf ~/.cabal/lib; \
    )
}

alias cabalupgrades="cabal list --installed  | egrep -iv '(synopsis|homepage|license)'"
