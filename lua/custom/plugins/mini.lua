return {
    {
	"echasnivski/mini.nvim",
	config = function()
	    local statusline = require("mini.statusline")
	    statusline.setup { use_icons = true }
	end
    }
}
