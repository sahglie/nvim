-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>.", "<c-^>")
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "U", "mmviw~`m")

local r = require("custom.runner")
vim.keymap.set("n", "<leader>r", r.run_ruby_script, { desc = "Run script and stream output" })
vim.keymap.set("n", "<leader>rd", r.run_rails_docker_script, { desc = "Run script in Docker and stream output" })

vim.keymap.set("n", "<leader>hi", ":set hls!<cr>")
vim.keymap.set("n", "<leader>w", ":set wrap!<cr>")
vim.keymap.set("n", "<leader>d", ":bp<bar>vs<bar>bn<bar>bd<cr>")

vim.keymap.set("n", ",1", require("oil").toggle_float, {})

vim.keymap.set("n", "tt", ":A<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>a", ":Gen<CR>")

-- vim.keymap.set("n", ",f", LazyVim.pick("files"))
-- vim.keymap.set("n", ",b", LazyVim.pick("buffers"))

-- vim.keymap.set("n", ",g", function()
--   Snacks.lazygit({ cwd = LazyVim.root.git() })
-- end, { desc = "Lazygit (Root Dir)" })

-- vim.keymap.set("n", "<leader>t", function()
--   require("neotest").run.run()
-- end)
