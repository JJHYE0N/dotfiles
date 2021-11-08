#!/usr/bin/env bash

# Lua
# sumneko_lua, LuaFormatter
install_lua_lsp() {
  local dest="$HOME/.cache/nvim/lspconfig/sumneko_lua/lua-language-server"
  if [ ! -d "$dest" ]; then
    mkdir -p "$HOME/.cache/nvim/lspconfig/sumneko_lua"
    # Fresh install
    local url="https://github.com/sumneko/lua-language-server"
    git clone --recurse-submodules $url $dest
    cd $dest && git submodule update --init --recursive
  else
    # git pull and rebuild
    git -C $dest pull --recurse-submodules
  fi

  cd $dest/3rd/luamake
  ./compile/install.sh
  cd $dest
  ./3rd/luamake/luamake rebuild
}

install_lua_formatter() {
  local dest="${PREFIX}/LuaFormatter"
  if [ ! -d "$dest" ]; then
    # Fresh install
    local url="https://github.com/Koihik/LuaFormatter.git"
    git clone --recurse-submodules $url $dest
  else
    # git pull and rebuild
    git -C $dest pull
  fi
  cmake -S "$dest" -B "$dest/build"
  cmake --build "$dest/build" -j 8
  sudo cmake --install "$dest/build"
}

install_lua() {
  install_lua_lsp
  install_lua_formatter
}

install_nvim() {
  local dest="${PREFIX}/neovim"
  if [ ! -d "$dest" ]; then
    local dependencies=(
      "ninja-build" "gettext" "libtool" "libtool-bin"
      "autoconf" "automake" "pkg-config" "unzip")
    sudo apt install ${dependencies[@]}
    git clone "https://github.com/neovim/neovim" $dest
    cd $dest
    make MIN_LOG_LEVEL=1 CMAKE_BUILD_TYPE=Release
    sudo make install

    local packer="https://github.com/wbthomason/packer.nvim"
    local packer_dest="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
    git clone $packer $packer_dest

    nvim +PackerInstall +qall
    nvim +PackerCompile +qall
  else
    git -C $dest pull

    cd $dest
    make MIN_LOG_LEVEL=1 CMAKE_BUILD_TYPE=Release
    sudo make install

    nvim +PackerSync +qall
  fi
}

install_shfmt() {
  local url="https://github.com/mvdan/sh"
  local link=$(curl -Ls $url/releases/latest | grep -wo "download/v.*/shfmt_v.*_linux_amd64")
  if command -v shfmt &>/dev/null; then
    local remote_version=$(echo $link | sed -rn 's/.*\/(.*)\/.*/\1/p')
    local local_version=$(shfmt --version)
    if [[ "$remote_version" = "$local_version" ]]; then
      echo "Already up to date ($remote_version)"
      return
    fi
    echo "Upgrading to $remote_version from $local_version"
  fi

  local output="$HOME/.local/bin/shfmt"
  curl -Lo $output "$url/releases/$link"
  chmod +x $output
}

install_external_dependencies() {
  # Python, CMake, Lua, Bash
  local python_packages=("pynvim" "autopep8" "isort" "cmake-language-server" "cmake-format")
  local npm_packages=("pyright" "bash-language-server")

  if ! command -v clang &>/dev/null; then
    pip3 install --upgrade ${python_packages[@]}
    sudo npm install --global ${npm_packages[@]}
    install_lua
    install_shfmt
  else
    pip3 install --upgrade ${python_packages[@]}
    sudo npm update ${npm_packages[@]}
    install_lua
    install_shfmt
  fi
}

install_external_dependencies
install_nvim
