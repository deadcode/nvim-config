return {
  "liuchengxu/vista.vim",
  config = function ()
    -- How each level is indented and what to prepend.
    -- This could make the display more compact or more spacious.
    -- e.g., morhttps://gigamon.zoom.us/j/98963948743?pwd=M1IxVzVhVUtFa2U5VzdtREwvV1BEQT09&from=addone compact: ["▸ ", ""]
    -- Note: this option only works for the kind renderer, not the tree renderer.
    vim.cmd("let g:vista_icon_indent = ['╰─▸ ', '├─▸ ']")

    -- Executive used when opening vista sidebar without specifying it.
    -- See all the avaliable executives via `:echo g:vista#executives`.
    vim.cmd("let g:vista_default_executive = 'ctags'")

    -- Set the executive for some filetypes explicitly. Use the explicit executives
    -- instead of the default one for these filetypes when using `:Vista` withoutspecifying
    -- specifying the executive.
    vim.cmd("let g:vista_executive_for = { 'cpp': 'vim_lsp', 'php': 'vim_lsp' }")

    -- Declare the command including the executable and options used to generate ctags output
    -- for some certain filetypes.The file path will be appened to your custom command.
    -- For example:
    vim.cmd("let g:vista_ctags_cmd = { 'haskell': 'hasktags -x -o - -c' }")

    -- To enable fzf's preview window set g:vista_fzf_preview.
    -- The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
    -- For example:
    vim.cmd("let g:vista_fzf_preview = ['right:50%']")

    -- Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
    vim.cmd("let g:vista#renderer#enable_icon = 1")

    -- The default icons can't be suitable for all the filetypes, you can extend it as you wish.
    vim.cmd("let g:vista#renderer#icons = { 'function': '\\uf794', 'variable': '\\uf71b' }")

    vim.cmd("let g:vista_sidebar_width = 45")
    -- How to show current cursor symbol
    --vim.cmd("let g:vista_echo_cursor_strategy = 'scroll'")
    vim.cmd("let g:vista_echo_cursor_strategy = 'floating_win'")
    -- Stay in current buffer when Vista is opened
    vim.cmd("let g:vista_stay_on_open = 0")
  end,
}
