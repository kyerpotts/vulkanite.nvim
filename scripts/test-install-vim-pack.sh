#!/bin/sh
set -eu

repo=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

if ! nvim --headless -u NONE -c 'if !has("nvim-0.12") | cquit 1 | endif' -c qa >/dev/null 2>&1; then
  printf 'vim.pack requires Neovim 0.12 or later.\n' >&2
  exit 1
fi

sandbox=$(mktemp -d -t vulkanite-vim-pack.XXXXXX)
trap 'rm -rf -- "$sandbox"' EXIT

mkdir -p \
  "$sandbox/config/nvim" \
  "$sandbox/data" \
  "$sandbox/state" \
  "$sandbox/cache" \
  "$sandbox/source"

cp -a "$repo/." "$sandbox/source/"
rm -rf -- "$sandbox/source/.git"
git -C "$sandbox/source" init --quiet
git -C "$sandbox/source" add .
git -C "$sandbox/source" \
  -c user.name=Vulkanite \
  -c user.email=vulkanite@example.invalid \
  commit --quiet -m snapshot

cat > "$sandbox/config/nvim/init.lua" <<'LUA'
vim.opt.termguicolors = true

vim.pack.add({
  {
    src = "file://" .. vim.env.VULKANITE_SOURCE,
    name = "vulkanite.nvim",
  },
})

require("vulkanite").setup({})
vim.cmd.colorscheme("vulkanite")
vim.cmd.syntax("enable")
LUA

printf '\nSandbox: %s\n' "$sandbox"
printf 'Verify with :lua assert(vim.g.colors_name == "vulkanite") and :help vulkanite\n'
printf 'The sandbox will be deleted when Neovim exits.\n\n'

if [ "$#" -eq 0 ]; then
  set -- "$repo/demo/showcase.lua"
fi

env \
  VULKANITE_SOURCE="$sandbox/source" \
  NVIM_APPNAME=nvim \
  XDG_CONFIG_HOME="$sandbox/config" \
  XDG_DATA_HOME="$sandbox/data" \
  XDG_STATE_HOME="$sandbox/state" \
  XDG_CACHE_HOME="$sandbox/cache" \
  nvim "$@"
