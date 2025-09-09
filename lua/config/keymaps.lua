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
-- vim.keymap.set("n", ",r", ":!%:p<cr>")

vim.keymap.set("n", ",r", function()
  local script_path = vim.fn.expand("%:p")
  vim.notify("running cmd: " .. script_path)
  local output = vim.fn.system(script_path)

  -- Create new buffer in vertical split
  vim.cmd("10new")

  -- Set buffer content
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(output, "\n"))

  -- Configure buffer settings
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.bo.filetype = "text" -- or 'log' for syntax highlighting

  -- Optional: set buffer name for identification
  vim.api.nvim_buf_set_name(0, "[Script Output] " .. vim.fn.fnamemodify(script_path, ":t"))

  -- Move cursor to top
  vim.cmd("normal! gg")
end, { desc = "Run script and capture output" })

-- vim.keymap.set("n", ",rd", ":!docker compose exec web % -e development<cr>")
vim.keymap.set("n", ",rd", function()
  local script_path = vim.fn.expand("%") -- Relative path instead of %:p
  local cmd = "docker compose exec web " .. script_path .. " -e development"
  vim.notify("running cmd: " .. cmd)
  local output = vim.fn.system(cmd)

  vim.cmd("15new")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(output, "\n"))

  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.bo.filetype = "text"

  vim.api.nvim_buf_set_name(0, "[Docker Output] " .. vim.fn.fnamemodify(script_path, ":t"))
  vim.cmd("normal! gg")
end, { desc = "Run script in Docker with relative path" })

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

vim.keymap.set("n", ",g", function()
  Snacks.lazygit({ cwd = LazyVim.root.git() })
end, { desc = "Lazygit (Root Dir)" })

vim.keymap.set("n", ",t", function()
  require("neotest").run.run()
end)
