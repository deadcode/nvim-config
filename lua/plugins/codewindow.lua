-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

return {
  'gorbit99/codewindow.nvim',
  config = function()
    local codewindow = require('codewindow')
    codewindow.setup()
    codewindow.apply_default_keybinds()
  end,
}
