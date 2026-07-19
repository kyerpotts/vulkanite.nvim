#!/bin/sh
set -eu

repo=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

if ! nvim --headless -u NONE -c 'if !has("nvim-0.11.2") | cquit 1 | endif' -c qa >/dev/null 2>&1; then
  printf 'Latest LazyVim requires Neovim 0.11.2 or later.\n' >&2
  exit 1
fi

if ! command -v cc >/dev/null 2>&1; then
  printf 'Latest LazyVim requires a C compiler for nvim-treesitter.\n' >&2
  exit 1
fi

sandbox=$(mktemp -d -t vulkanite-lazyvim.XXXXXX)
trap 'rm -rf -- "$sandbox"' EXIT

mkdir -p \
  "$sandbox/config" \
  "$sandbox/data" \
  "$sandbox/state" \
  "$sandbox/cache"

git clone --filter=blob:none https://github.com/LazyVim/starter \
  "$sandbox/config/nvim"
rm -rf -- "$sandbox/config/nvim/.git"
mkdir -p "$sandbox/config/nvim/lua/plugins"

cat > "$sandbox/config/nvim/lua/plugins/vulkanite.lua" <<'LUA'
return {
  {
    dir = vim.env.VULKANITE_REPO,
    name = "vulkanite.nvim",
    lazy = false,
    priority = 1000,
    main = "vulkanite",
    opts = {},
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vulkanite",
    },
  },
}
LUA

printf '\nSandbox: %s\n' "$sandbox"
printf 'Wait for LazyVim to finish installing, then restart if prompted.\n'
printf 'Run :LazyHealth, then verify with :lua assert(vim.g.colors_name == "vulkanite") and :help vulkanite\n'
printf 'The sandbox will be deleted when Neovim exits.\n\n'

if [ "$#" -eq 0 ]; then
  set -- "$repo/demo/showcase.lua"
fi

env \
  VULKANITE_REPO="$repo" \
  NVIM_APPNAME=nvim \
  XDG_CONFIG_HOME="$sandbox/config" \
  XDG_DATA_HOME="$sandbox/data" \
  XDG_STATE_HOME="$sandbox/state" \
  XDG_CACHE_HOME="$sandbox/cache" \
  nvim "$@"
