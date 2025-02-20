
return {
  'MeanderingProgrammer/render-markdown.nvim',
  config = function()
    local rmd = require('render-markdown')
    local opts = {
    }
    rmd.setup(opts)
  end,
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
}
