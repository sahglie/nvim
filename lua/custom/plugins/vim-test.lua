return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
    "tpope/vim-dispatch",
  },
  config = function()
    vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", {})
    vim.keymap.set("n", "<leader>T", ":TestFile<CR>", {})
    vim.keymap.set("n", "<leader>a", ":TestSuite<CR>", {})
    vim.keymap.set("n", "<leader>l", ":TestLast<CR>", {})
    vim.keymap.set("n", "<leader>g", ":TestVisit<CR>", {})
    --vim.cmd("let test#strategy = 'vimux'")
    --
    --
    vim.cmd([[
      function! DockerTransform(cmd) abort
        " let l:docker = "docker compose exec -e RAILS_ENV=test -e SKIP_CSS_BUILD=true -e SKIP_JS_BUILD=true web"

        " Get git root directory
        " let l:git_root = trim(system('git rev-parse --show-toplevel'))
        " let l:config_path = l:git_root . '/.vimtest.config'
        let l:config_path = '.vimtest.config'

        " Check if config file exists
        if filereadable(l:config_path)
            let l:config_contents = readfile(l:config_path)
            if len(l:config_contents) > 0
              let l:docker = l:config_contents[0]
              return l:docker . " " . a:cmd
            endif
        endif

        return a:cmd
      endfunction

      let g:test#custom_transformations = {'docker': function('DockerTransform')}
      let g:test#transformation = 'docker'
    ]])
  end,
}
