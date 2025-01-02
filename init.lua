print("advent of neovim")

require("config.lazy")

vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"

--vim.cmd [[hi @function.builtin.lua guifg=yellow]]

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copyting) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {clear = true}),
    callback = function()
	vim.highlight.on_yank()
    end,
})
