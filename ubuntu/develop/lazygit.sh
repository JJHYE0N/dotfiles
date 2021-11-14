#!/usr/bin/env bash

fetch_from_git_lazygit() {
  local tmpdir=$(dirname $(mktemp -u))
  if command -v lazygit &>/dev/null; then
    local local_version=$(lazygit --version | sed -rn 's/.*version=([^,]*).*/\1/p')
    fetch_from_git "jesseduffield/lazygit" \
      "lazygit_.*_Linux_x86_64.tar.gz" \
      $tmpdir \
      $local_version
  else
    fetch_from_git "jesseduffield/lazygit" \
      "lazygit_.*_Linux_x86_64.tar.gz" \
      $tmpdir
  fi

  local output="$(compgen -G $tmpdir/lazygit_*)"
  if [[ -f $output ]]; then
    msg info "extracting binary"
    tar -xzf $output --directory "$HOME/.local/bin"
    rm $output
    rm "$HOME/.local/bin/LICENSE" "$HOME/.local/bin/README.md"
  fi
}

fetch_from_git_lazygit
