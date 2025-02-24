return {
  "lewis6991/gitsigns.nvim",
  version = "*",
  opts = {
    signs = {
      add = { text = "✓" },
      change = { text = "󰣕" },
      delete = { text = "" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "★" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
--    yadm = {
--      enable = false,
--    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      -- Actions
      map('n', '<leader>ghs', gs.stage_hunk, { desc = "Stage Hunk" })
      map('n', '<leader>ghr', gs.reset_hunk, { desc = "Reset Hunk" })
      map('v', '<leader>ghs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage Hunk" })
      map('v', '<leader>ghr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset Hunk" })
      map('n', '<leader>ghS', gs.stage_buffer, { desc = "Stage Buffer" })
      map('n', '<leader>ghu', gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
      map('n', '<leader>ghR', gs.reset_buffer, { desc = "Reset Buffer" })
      map('n', '<leader>ghp', gs.preview_hunk, { desc = "Preview Hunk" })
      map('n', '<leader>ghb', function() gs.blame_line{full=true} end, { desc = "Blame Line" })
      map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = "Toggle Blame Line" })
      map('n', '<leader>ghd', gs.diffthis, { desc = "Diff This" })
      map('n', '<leader>ghD', function() gs.diffthis('~') end, { desc = "Diff This ~" })
      map('n', '<leader>gtd', gs.toggle_deleted, { desc = "Toggle Deleted" })

      -- Text object
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end,
  },
}
