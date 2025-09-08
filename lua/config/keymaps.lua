-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--vim.keymap.set('n', '<leader>y', '"*yy')
--vim.keymap.set('v', '<leader>y', '"*y')
--vim.keymap.set('n', '<leader>p', '"*p')

-- vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
-- vim.keymap.set("n", "<space>x", ":.lua<CR>")
-- vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<leader>.", "<c-^>")
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "U", "mmviw~`m")
vim.keymap.set("n", "<leader>r", ":!%:p<cr>")
vim.keymap.set("n", "<leader>rd", ":!docker compose exec web % -e development<cr>")
vim.keymap.set("n", "<leader>h", ":set hls!<cr>")
vim.keymap.set("n", "<leader>w", ":set wrap!<cr>")
vim.keymap.set("n", "<leader>d", ":bp<bar>vs<bar>bn<bar>bd<cr>")

-- Move around splits with <c-hjkl>
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-l>", "<c-w>l")

vim.keymap.set("n", "tt", ":A<CR>", { noremap = true, silent = true })

vim.keymap.set("n", ",f", LazyVim.pick("files"))
vim.keymap.set("n", ",b", LazyVim.pick("buffers"))
--vim.keymap.set("n", ",g", ":LazyGit<CR>", { noremap = true, silent = true })
vim.keymap.set("n", ",g", function()
  Snacks.lazygit({ cwd = LazyVim.root.git() })
end, { desc = "Lazygit (Root Dir)" })

-- NvimTmuxNaviator
vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", {})
--vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", {})
vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", {})

vim.keymap.set("n", ",t", function()
  require("neotest").run.run()
end)
