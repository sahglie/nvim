-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Disable relative line numbers
vim.opt.relativenumber = false

-- In your config
-- vim.lsp.set_log_level("debug")
-- Check logs at ~/.local/state/nvim/lsp.log
-- In your Mason configuration
--
vim.g.lazyvim_ruby_formatter = "standardrb"

-- Then, define your custom highlight group
-- vim.api.nvim_set_hl(0, "FzfLuaSelection", { bg = "#dddddd" })
