find "$HOME/.pyenv/versions" -name "*-brew" | xargs rm -d

for i in `ls $(brew --cellar python)/`; do
  ln -s $(brew --cellar python)/$i $HOME/.pyenv/versions/$i-brew;
done

for i in `ls $(brew --cellar python3)/`; do
  ln -s $(brew --cellar python3)/$i $HOME/.pyenv/versions/$i-brew;
done
