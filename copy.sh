mkdir -p ../.vim

# We still need this.
windows() { [[ -n "$WINDIR" ]]; }


if windows; then
  cmd.exe //c "mklink %USERPROFILE%\.vim\neobundle.toml %USERPROFILE%\dotfiles\.vim\neobundle.toml"
  cmd.exe //c "mklink %USERPROFILE%\.vim\neobundlelazy.toml %USERPROFILE%\dotfiles\.vim\neobundlelazy.toml"
  cmd.exe //c "mklink %USERPROFILE%\.vimrc %USERPROFILE%\dotfiles\.vimrc"
  cmd.exe //c "mklink %USERPROFILE%\.gvimrc %USERPROFILE%\dotfiles\.gvimrc"
else
  ln -s ~/dotfiles/.vim/neobundle.toml ~/.vim/neobundle.toml
  ln -s ~/dotfiles/.vim/neobundlelazy.toml ~/.vim/neobundlelazy.toml
  ln -s ~/dotfiles/.vimrc ~/.vimrc
  ln -s ~/dotfiles/.gvimrc ~/.gvimrc
fi

