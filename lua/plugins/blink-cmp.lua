return {
  "nvim-mini/blink.cmp",
  opts = function(_, opts)
    -- The 'enabled' option can be a function.
    -- We'll check the buffer's filetype ('vim.bo.ft')
    -- and only return true if it's NOT markdown.
    opts.enabled = function()
      return vim.bo.ft ~= "markdown"
    end
  end,
}
