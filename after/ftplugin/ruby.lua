local set = vim.opt_local

set.shiftwidth = 2
set.number = true

local hi = vim.api.nvim_set_hl

-- Define the colors you need for this language
local ruby_colors = {
  light_green = "#A5C261",
  white = "#FFFFFF",
  light_white = "#DDDDDD",
  string = "#A5C261",
  blue = "#639CBE",
  symbol = "#639CBE",
  clay_red = "#CC7833",
}

-- Set the highlight groups for Ruby-specific tokens
hi(0, "@variable", { fg = ruby_colors.white })
hi(0, "@string.ruby", { fg = ruby_colors.light_green })
hi(0, "@string.special.symbol.ruby", { fg = ruby_colors.blue })
hi(0, "@function.call.ruby", { fg = ruby_colors.light_white })
hi(0, "@constant.ruby", { fg = ruby_colors.blue })
hi(0, "@type.ruby", { fg = ruby_colors.blue })
hi(0, "@lsp.type.method.ruby", { fg = ruby_colors.clay_red })
hi(0, "@boolean.ruby", { fg = ruby_colors.clay_red })
hi(0, "@lsp.type.class.ruby", { fg = ruby_colors.blue })
hi(0, "@lsp.type.namespace.ruby", { fg = ruby_colors.blue })
hi(0, "@lsp.typemod.class.declaration.ruby", { fg = ruby_colors.white, bold = true })
hi(0, "@lsp.typemod.namspace.declaration.ruby", { fg = ruby_colors.white, bold = true })
hi(0, "@variable.ruby", { fg = ruby_colors.light_white })
hi(0, "@punctuation.delimiter.ruby", { fg = ruby_colors.white })
hi(0, "@punctuation.bracket.ruby", { fg = ruby_colors.white })
