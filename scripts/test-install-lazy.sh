#!/bin/sh
set -eu

repo=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
sandbox=$(mktemp -d -t vulkanite-lazy.XXXXXX)
trap 'rm -rf -- "$sandbox"' EXIT

mkdir -p \
  "$sandbox/config/nvim" \
  "$sandbox/data" \
  "$sandbox/state" \
  "$sandbox/cache"

cat > "$sandbox/config/nvim/init.lua" <<'LUA'
vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    dir = vim.env.VULKANITE_REPO,
    name = "vulkanite.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vulkanite").setup({})
      vim.cmd.colorscheme("vulkanite")
      vim.cmd.syntax("enable")
    end,
  },
})
LUA

printf '\nSandbox: %s\n' "$sandbox"
printf 'Verify with :lua assert(vim.g.colors_name == "vulkanite") and :help vulkanite\n'
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
