#!/usr/bin/env bash

install_cargo_utilities() {
  local packages=("alacritty" "git-delta" "exa" "bat" "fd-find" "ripgrep" "bottom")
  cargo install ${packages[@]}
}

install_alacritty() {
  local url="https://github.com/alacritty/alacritty.git"
  local dir="${prefix}/alacritty"

  if [ -d "$dir" ]; then
    git -C $dir pull
  else
    local dependencies=("pkg-config" "libfreetype6-dev" "libfontconfig1-dev" "libxcb-xfixes0-dev")
    sudo apt install ${dependencies[@]}
    # Fresh install
    git clone $url "$dir"
  fi
  cd $dir

  cargo build --release
  # Install binaries
  sudo cp target/release/alacritty /usr/local/bin
  sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
  sudo desktop-file-install extra/linux/Alacritty.desktop
  sudo update-desktop-database -q

  sudo mkdir -p /usr/local/share/man/man1
  gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz >/dev/null

  mkdir -p ${ZDOTDIR:-~}/.zsh_functions
  cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty
}

install_bat() {
  local url="https://github.com/sharkdp/bat"
  local dir="${prefix}/bat"

  if [ -d "$dir" ]; then
    git -C $dir pull
  else
    git clone $url "$dir"
  fi
  cd $dir

  cargo build --release
  sudo cp target/release/bat /usr/local/bin

  local man=target/release/build/bat-*/out/assets/manual/bat.1
  gzip -c $man | sudo tee /usr/local/share/man/man1/bat.1.gz >/dev/null

  mkdir -p ${ZDOTDIR:-~}/.zsh_functions
  local autocomp=target/release/build/bat-*/out/assets/completions/bat.zsh
  cp $autocomp ${ZDOTDIR:-~}/.zsh_functions/_bat
}

install_bottom() {
  local url="https://github.com/ClementTsang/bottom"
  local dir="${prefix}/bottom"

  if [ -d "$dir" ]; then
    git -C $dir pull
  else
    git clone $url "$dir"
  fi
  cd $dir

  cargo build --release
  sudo cp target/release/btm /usr/local/bin

  # No man page?

  mkdir -p ${ZDOTDIR:-~}/.zsh_functions
  local autocomp=target/release/build/bottom-*/out/_btm
  cp $autocomp ${ZDOTDIR:-~}/.zsh_functions/_btm
}

install_exa() {
  local url="https://github.com/ogham/exa"
  local dir="${prefix}/exa"

  if [ -d "$dir" ]; then
    git -C $dir pull
  else
    local dependencies=("pandoc")
    sudo apt install ${dependencies[@]}
    git clone $url "$dir"
  fi
  cd $dir

  cargo build --release
  sudo cp target/release/exa /usr/local/bin

  pandoc --standalone -f markdown -t man man/exa.1.md >"exa.1"
  pandoc --standalone -f markdown -t man man/exa_colors.5.md >"exa_colors.5"
  gzip -c "exa.1" | sudo tee /usr/local/share/man/man1/exa.1.gz >/dev/null
  gzip -c "exa_colors.5" | sudo tee /usr/local/share/man/man1/exa_colors.5.gz >/dev/null

  mkdir -p ${ZDOTDIR:-~}/.zsh_functions
  cp completions/zsh/_exa ${ZDOTDIR:-~}/.zsh_functions/_exa
}

install_fd() {
  local url="https://github.com/sharkdp/fd"
  local dir="${prefix}/fd"

  if [ -d "$dir" ]; then
    git -C $dir pull
  else
    git clone $url "$dir"
  fi
  cd $dir

  cargo build --release
  sudo cp target/release/fd /usr/local/bin
  gzip -c doc/fd.1 | sudo tee /usr/local/share/man/man1/fd.1.gz >/dev/null

  mkdir -p ${ZDOTDIR:-~}/.zsh_functions
  cp contrib/completion/_fd ${ZDOTDIR:-~}/.zsh_functions/_fd
}

install_gitdelta() {
  local url="https://github.com/dandavison/delta"
  local dir="${prefix}/delta"

  if [ -d "$dir" ]; then
    git -C $dir pull
  else
    git clone $url "$dir"
  fi
  cd $dir

  cargo build --release
  sudo cp target/release/delta /usr/local/bin
  # No man page or zsh completion
}

install_ripgrep() {
  local url="https://github.com/BurntSushi/ripgrep"
  local dir="${prefix}/ripgrep"

  if [ -d "$dir" ]; then
    git -C $dir pull
  else
    local dependencies=("asciidoc")
    sudo apt install ${dependencies[@]}
    git clone $url "$dir"
  fi
  cd $dir

  cargo build --release
  sudo cp target/release/rg /usr/local/bin

  local man=target/release/build/ripgrep-*/out/rg.1
  gzip -c $man | sudo tee /usr/local/share/man/man1/rg.1.gz >/dev/null

  mkdir -p ${ZDOTDIR:-~}/.zsh_functions
  cp complete/_rg ${ZDOTDIR:-~}/.zsh_functions/_rg
}

install_cargo_utilities
