-- Change leader to a comma
vim.g.mapleader = ","

local core_conf_files = {
  "globals.vim",
  "buf_utils.vim",
  "text_obj.vim",
  "utils.vim",
  -- 'options.vim',
  -- 'autocommands.vim',
  -- 'mappings.vim',
  -- 'plugins.vim',
  -- 'themes.vim'
}

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

for _, fname in ipairs(core_conf_files) do
  vim.cmd("source " .. vim.fn.stdpath("config") .. "/utils/" .. fname)
end

vim.cmd("colorscheme tokyonight-night")
