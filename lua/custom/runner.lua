local M = {}

function M.run_ruby_script()
  if M.output_bufnr and not vim.api.nvim_buf_is_valid(M.output_bufnr) then
    M.output_bufnr = nil
  end

  local script_path = vim.fn.expand("%:p")

  if not M.output_bufnr then
    -- Create new split and buffer
    vim.cmd("10new")
    M.output_bufnr = vim.api.nvim_get_current_buf()
    vim.bo[M.output_bufnr].buftype = "nofile"
    vim.bo[M.output_bufnr].bufhidden = "hide"
    vim.bo[M.output_bufnr].swapfile = false
    vim.bo[M.output_bufnr].filetype = "text"
    vim.api.nvim_buf_set_name(M.output_bufnr, "[Script Output]")
  else
    local win_id = vim.fn.bufwinid(M.output_bufnr)
    if win_id ~= -1 then
      -- If buffer is visible, jump to it
      vim.api.nvim_set_current_win(win_id)
    else
      -- If buffer exists but is hidden, open it in a split
      vim.cmd("10sbuffer " .. M.output_bufnr)
    end
    -- Clear previous output
    vim.api.nvim_buf_set_lines(M.output_bufnr, 0, -1, false, {})
  end

  vim.notify("Running: " .. script_path)

  local function is_cursor_at_bottom()
    local win_id = vim.fn.bufwinid(M.output_bufnr)
    if win_id == -1 then
      return false
    end
    local cursor_line = vim.api.nvim_win_get_cursor(win_id)[1]
    local last_line = vim.api.nvim_buf_line_count(M.output_bufnr)
    return cursor_line == last_line
  end

  vim.fn.jobstart({ script_path }, {
    stdout_buffered = false,
    on_stdout = function(_, data, _)
      if not data or (#data == 1 and data[1] == "") then
        return
      end
      local should_scroll = is_cursor_at_bottom()
      vim.api.nvim_buf_set_lines(M.output_bufnr, -1, -1, false, data)
      if should_scroll then
        local win_id = vim.fn.bufwinid(M.output_bufnr)
        if win_id ~= -1 then
          vim.api.nvim_win_set_cursor(win_id, { vim.api.nvim_buf_line_count(M.output_bufnr), 0 })
        end
      end
    end,
    on_stderr = function(_, data, _)
      if data and #data > 0 and not (#data == 1 and data[1] == "") then
        vim.api.nvim_buf_set_lines(M.output_bufnr, -1, -1, false, data)
      end
    end,
    on_exit = function(_, code, _)
      vim.api.nvim_buf_set_lines(M.output_bufnr, -1, -1, false, { "", "[Process exited with code: " .. code .. "]" })
    end,
  })
end

function M.run_rails_docker_script()
  local script_path = vim.fn.expand("%") -- Relative path
  local cmd = { "docker", "compose", "exec", "web", script_path, "-e", "development" }

  -- Create output window
  vim.cmd("15new")
  local bufnr = vim.api.nvim_get_current_buf()

  -- Buffer settings
  vim.bo[bufnr].buftype = "nofile"
  vim.bo[bufnr].bufhidden = "wipe"
  vim.bo[bufnr].swapfile = false
  vim.bo[bufnr].filetype = "text"
  vim.api.nvim_buf_set_name(bufnr, "[Docker Output] " .. vim.fn.fnamemodify(script_path, ":t"))

  vim.notify("Running: " .. table.concat(cmd, " "))

  -- Helper: Is cursor at last line?
  local function is_at_bottom()
    local win = vim.fn.bufwinnr(bufnr)
    if win == -1 then
      return false
    end
    local cursor_line = vim.fn.line(".", win)
    local last_line = vim.api.nvim_buf_line_count(bufnr)
    return cursor_line == last_line
  end

  -- Start async job
  vim.fn.jobstart(cmd, {
    stdout_buffered = false,
    stderr_buffered = false,
    on_stdout = function(_, data, _)
      if not data or (#data == 1 and data[1] == "") then
        return
      end
      vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
      if is_at_bottom() then
        vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(bufnr), 0 })
      end
    end,
    on_stderr = function(_, data, _)
      if not data or (#data == 1 and data[1] == "") then
        return
      end
      vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
      if is_at_bottom() then
        vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(bufnr), 0 })
      end
    end,
    on_exit = function(_, code, _)
      vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { "", "[Process exited: " .. code .. "]" })
    end,
  })
end

return M
