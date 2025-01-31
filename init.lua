-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

--vim.keymap.set('n', '<leader>y', '"*yy')
--vim.keymap.set('v', '<leader>y', '"*y')
--vim.keymap.set('n', '<leader>p', '"*p')

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set('n', '<leader>.', '<c-^>')
vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')
vim.keymap.set('n', 'U', 'mmviw~`m')
vim.keymap.set('n', '<leader>r', ':!%:p<cr>')
vim.keymap.set('n', '<leader>h', ':set hls!<cr>')
vim.keymap.set('n', '<leader>w', ':set wrap!<cr>')
vim.keymap.set('n', '<leader>d', ':bp<bar>vs<bar>bn<bar>bd<cr>')
vim.keymap.set('n', '<leader>1', ':NvimTreeToggle<cr>')

-- Move around splits with <c-hjkl>
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-l>", "<c-w>l")

require("config.lazy")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copyting) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
