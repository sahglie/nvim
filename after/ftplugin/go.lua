local set = vim.opt_local

set.shiftwidth = 4
set.tabstop = 4
set.number = true

local hi = vim.api.nvim_set_hl

-- Define the colors you need for this language
local golang_colors = {
  light_green = "#A5C261",
  white = "#FFFFFF",
  blue = "#639CBE",
  clay_red = "#CC7833",
}

-- Set the highlight groups for Golang-specific tokens
hi(0, "@type.go", { fg = golang_colors.blue })
hi(0, "@type.definition.go", { fg = golang_colors.blue, bold = true })
hi(0, "@lsp.typemod.type.struct.go", { fg = golang_colors.blue, bold = true })
hi(0, "@module.go", { fg = golang_colors.blue })
--hi(0, "@string.go", { fg = golang_colors.light_green })
