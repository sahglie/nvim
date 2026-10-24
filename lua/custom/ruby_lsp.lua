-- lua/util/ruby_lsp.lua
local M = {}

function M.go_to_relevant_file()
  local client = vim.lsp.get_clients({ bufnr = 0, name = "ruby_lsp" })[1]
  if not client then
    return vim.notify("ruby_lsp not attached to this buffer")
  end

  client:request("experimental/goToRelevantFile", {
    textDocument = { uri = vim.uri_from_bufnr(0) },
  }, function(err, res)
    if err then
      return vim.notify(vim.inspect(err), vim.log.levels.ERROR)
    end
    local paths = (res and res.locations) or res or {}
    if #paths == 0 then
      return vim.notify("No relevant file found")
    end

    local function open(p)
      if p:match("^file://") then
        p = vim.uri_to_fname(p)
      end
      vim.cmd.edit(vim.fn.fnameescape(p))
    end

    if #paths == 1 then
      open(paths[1])
    else
      vim.ui.select(paths, { prompt = "Relevant file" }, function(p)
        if p then
          open(p)
        end
      end)
    end
  end)
end

return M
