#!/usr/bin/env bash
((TRACE)) && set -x

set -euo pipefail

build_path="${XDG_DATA_HOME}/nvim/lsp/sumneko_lua"

build_server() {
  echo ':: Building sumneko lua-language-server'
  cd "${build_path}/3rd/luamake"
  ninja -f compile/ninja/macos.ninja

  cd "${build_path}"
  ./3rd/luamake/luamake rebuild
}

if [[ ! -d "${build_path}" ]]; then
  mkdir -p "${build_path}"
  git clone https://github.com/sumneko/lua-language-server "${build_path}"

  cd "${build_path}"

  git submodule update --init --recursive
  build_server
fi

cd "${build_path}"

git -c gc.auto=0 fetch --quiet --no-tags --recurse-submodules=no >/dev/null 2>&1

behind=$(git rev-list --right-only --count HEAD...@'{u}' 2>/dev/null)
if ((behind)); then
  git pull --quiet
  git submodule update --init --recursive

  git --no-pager log --no-merges --stat --color ORIG_HEAD..

  build_server
fi
