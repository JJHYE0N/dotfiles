#!/usr/bin/env bash

set -euo pipefail

install_cmake() {
  pip install --quiet --user cmake
  whereis cmake
  cmake --version
}

install_cmake
