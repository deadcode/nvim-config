-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  if type(rhs) == "string" then
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  else
    vim.keymap.set(mode, lhs, rhs, options)
  end
end

-- Append mapping
local function amap(mode, lhs, rhs)
  local lmap = vim.tbl_filter(function(x)
    return x.lhs == lhs
  end, vim.api.nvim_get_keymap(mode))[1]
  if not lmap then
    return
  end
  vim.keymap.set(mode, lhs, lmap.rhs .. rhs)
end

-- Change leader to a comma
-- vim.g.mapleader = ","

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Save key strokes (now we do not need to press shift to enter command mode).
-- Vim-sneak has also mapped `;`, so using the below mapping will break the map
-- used by vim-sneak
map("n", ";", ":")
map("x", ";", ":")

-- Quicker way to open command window
map("n", "q;", "q:")

-- Turn the word under cursor to upper case
map("i", "<c-u>", "<Esc>viwUea")

-- Turn the current word into title case
map("i", "<c-t>", "<Esc>b~lea")

-- Paste non-linewise text above or below current cursor,
-- see https://stackoverflow.com/a/1346777/6064933
map("n", "<leader>p", "m`o<ESC>p``")
map("n", "<leader>P", "m`O<ESC>p``")

-- Shortcut for faster save and quit
map("n", "<leader>w", ":<C-U>update<CR>")
-- Saves the file if modified and quit
map("n", "<leader>q", ":<C-U>x<CR>")
-- Quit all opened buffers
map("n", "<leader>Q", ":<C-U>qa!<CR>")

-- Navigation in the location and quickfix list
map("n", "[l", ":<C-U>lprevious<CR>zv")
map("n", "]l", ":<C-U>lnext<CR>zv")
map("n", "[L", ":<C-U>lfirst<CR>zv")
map("n", "]L", ":<C-U>llast<CR>zv")
map("n", "[q", ":<C-U>cprevious<CR>zv")
map("n", "]q", ":<C-U>cnext<CR>zv")
map("n", "[Q", ":<C-U>cfirst<CR>zv")
map("n", "]Q", ":<C-U>clast<CR>zv")

-- Close location list or quickfix list if they are present,
-- see https://superuser.com/q/355325/736190
map("n", "\\x", ":<C-U>windo lclose <bar> cclose<CR>")

-- Close a buffer and switching to another buffer, do not close the
-- window, see https://stackoverflow.com/q/4465095/6064933
map("n", "\\d", ":<C-U>bprevious <bar> bdelete #<CR>")

-- Insert a blank line below or above current line (do not move the cursor),
-- see https://stackoverflow.com/a/16136133/6064933
map("n", "<Space>o", "printf('m`%so<ESC>``', v:count1)", { expr = true })
map("n", "<Space>O", "printf('m`%sO<ESC>``', v:count1)", { expr = true })

-- Insert a space after current character
map("n", "<Space><Space>", "a<Space><ESC>h")

-- Move the cursor based on physical lines, not the actual lines.
map("n", "j", "(v:count == 0 ? 'gj' : 'j')", { expr = true })
map("n", "k", "(v:count == 0 ? 'gk' : 'k')", { expr = true })
map("n", "^", "g^")
map("n", "0", "g0")

-- Do not include white space characters when using $ in visual mode,
-- see https://vi.stackexchange.com/q/12607/15292
map("x", "$", "g_")

-- Jump to matching pairs easily in normal mode
map("n", "<Tab>", "%")

-- Go to start or end of line easier
map("n", "H", "^")
map("x", "H", "^")
map("n", "L", "g_")
map("x", "L", "g_")

-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://superuser.com/q/310417/736190
map("x", "<", "<gv")
map("x", ">", ">gv")

-- When completion menu is shown, use <cr> to select an item and do not add an
-- annoying newline. Otherwise, <enter> is what it is. For more info , see
-- https://superuser.com/a/941082/736190 and
-- https://unix.stackexchange.com/q/162528/221410
-- inoremap <expr> <cr> ((pumvisible())?("\<C-Y>"):("\<cr>"))
-- Use <esc> to close auto-completion menu
-- inoremap <expr> <esc> ((pumvisible())?("\<C-e>"):("\<esc>"))

-- Tab-complete, see https://vi.stackexchange.com/q/19675/15292.
map("i", "<tab>", "pumvisible() ? '<c-n>' : '<tab>'", { expr = true })
map("i", "<s-tab>", "pumvisible() ? '<c-p>' : '<s-tab>'", { expr = true })

-- Edit and reload init.vim quickly
map("n", "<leader>ev", ":<C-U>tabnew $MYVIMRC <bar> tcd %:h<cr>")
map(
  "n",
  "<leader>sv",
  ":<C-U>silent update $MYVIMRC <bar> source $MYVIMRC <bar> call v:lua.vim.notify('Nvim config successfully reloaded!', 'info', {'title': 'nvim-config'})<cr>"
)

-- Reselect the text that has just been pasted, see also https://stackoverflow.com/a/4317090/6064933.
map("n", "<leader>v", "printf('`[%s`]', getregtype()[0])", { expr = true })

-- Always use very magic mode for searching
map("n", "/", "/\v")

-- Search in selected region
map("x", "/", ":<C-U>call feedkeys('/%>'.(line('<)-1).'l%<'.(line('>)+1).l)<CR>")

-- Find and replace (like Sublime Text 3)
map("n", "<C-H>", ":%s/")
map("x", "<C-H>", ":s/")

-- Change current working directory locally and print cwd after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
map("n", "<leader>cd", ":<C-U>lcd %:p:h<CR>:pwd<CR>")

-- Use Esc to quit builtin terminal
--map("t", "<ESC>", "<C-\\><C-n>")

-- Toggle spell checking (autosave does not play well with z=, so we disable it
-- when we are doing spell checking)
map("n", "<F11>", ":<C-U>set spell!<cr>")
map("i", "<F11>", "<C-O>:<C-U>set spell!<cr>")

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
map("n", "c", '"_c')
map("n", "C", '"_C')
map("n", "cc", '"_cc')
map("x", "c", '"_c')

-- Remove trailing whitespace characters
map("n", "<leader><Space>", ":<C-U>StripTrailingWhitespace<CR>")

-- check the syntax group of current cursor position
map("n", "<leader>st", ":<C-U>call utils#SynGroup()<CR>")

-- Clear highlighting
if vim.fn.maparg("<C-L>", "n") == #"" then
  map("n", "<C-L>", ":<C-U>nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>")
end

-- Copy entire buffer.
map("n", "<leader>y", ":<C-U>%y<CR>")

-- Toggle cursor column
map("n", "<leader>cl", ":<C-U>call utils#ToggleCursorCol()<CR>")

-- Move current line up and down
map("n", "<A-k>", "<Cmd>call utils#SwitchLine(line('.'), 'up')<CR>")
map("n", "<A-j>", "<Cmd>call utils#SwitchLine(line('.'), 'down')<CR>")

-- Move current visual-line selection up and down
map("n", "<A-k>", ":<C-U>call utils#MoveSelection('up')<CR>")
map("c", "<A-j>", ":<C-U>call utils#MoveSelection('down')<CR>")

-- Replace visual selection with text in register, but not contaminate the
-- register, see also https://stackoverflow.com/q/10723700/6064933.
map("x", "p", '"_c<ESC>p')

map("n", "gb", ":<C-U>call buf_utils#GoToBuffer(v:count, 'forward')<CR>")
map("n", "gB", ":<C-U>call buf_utils#GoToBuffer(v:count, 'backward')<CR>")

--map("n", "<Left>", "<C-W>h")
--map("n", "<Right>", "<C-W>l")
--map("n", "<Up>", "<C-W>k")
--map("n", "<Down>", "<C-W>j")

-- Text objects for URL
map("x", "iu", ":<C-U>call text_obj#URL()<CR>")
map("o", "iu", ":<C-U>call text_obj#URL()<CR>")

-- Text objects for entire buffer
map("x", "iB", ":<C-U>call text_obj#Buffer()<CR>")
map("o", "iB", ":<C-U>call text_obj#Buffer()<CR>")

-- Do not move my cursor when joining lines.
map("n", "J", "mzJ`z")

-- Break inserted text into smaller undo units.
for _, ch in ipairs({ ",", ".", "!", "?", ";", ":" }) do
  local map_cmd = string.format("map('i', '%s', '%s<C-g>u'", ch, ch)
  --vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  loadstring(map_cmd)
end

-- insert semicolon in the end
map("i", "<A-;>", "<ESC>miA;<ESC>`ii")

-- Keep cursor position after yanking
map("n", "y", "myy")
map("x", "y", "myy")

local restore_after_yank_grp = vim.api.nvim_create_augroup("restore_after_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  command = "lua call restore_cursor()",
  group = restore_after_yank_grp,
})

local function restore_cursor()
  vim.cmd("`y")
  vim.cmd("delmarks y")
end
--function! s:restore_cursor() abort
--  silent! normal `y
--  silent! delmarks y
--endfunction

-- Go to the begining and end of current line in insert mode quickly
map("i", "<C-A>", "<HOME>")
map("i", "<C-E>", "<END>")

-- Delete the character to the right of the cursor
map("i", "<C-D>", "<DEL>")

-- Move around splits using Ctrl + {h,j,k,l}
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- NvimTree
map("n", "<leader>nt", ":NvimTreeToggle<CR>", { desc = "Toggle Nvim-Tree" }) -- open/close
map("n", "<leader>nTr", ":NvimTreeRefresh<CR>", { desc = "Refresh Nvim-Tree" }) -- refresh
map("n", "<leader>nTf", ":NvimTreeFindFile<CR>", { desc = "Find file Nvim-Tree" }) -- search file

-- Tagbar
map("n", "<leader>z", ":TagbarToggle<CR>") -- open/close

local cschemes = {
  { "tokyonight-night", "tokyonight", "night" },
  { "tokyonight-day", "tokyonight", "day" },
  { "solarized", "solarized", "dark" },
  { "solarized", "solarized", "light" },
  { "default", "default", nil },
  { "desert", "desert", nil },
  { "gruvbox", "gruvbox", nil },
  { "lunaperche", "lunaperche", nil },
  { "habamax", "habamax", nil },
  { "peachpuff", "peachpuff", nil },
}

function cycle_colorschemes()
  local current_scheme = vim.g.colors_name
  local next_scheme = "default"
  local cschemes_size = table.getn(cschemes)
  local ii = 0

  for i, _ in ipairs(cschemes) do
    local cscheme_name = cschemes[i][2]
    local cscheme_style = cschemes[i][3]
    vim.notify(
      "i=" .. i .. " " .. cscheme_name .. cscheme_style .. " " .. current_scheme,
      "info",
      { "title", "cycle_colorschemes" }
    )
    if cscheme_name == current_scheme then
      if i == cschemes_size then
        ii = 1
      else
        ii = i + 1
      end
      vim.notify("cschemes_size=" .. cschemes_size .. " ii=" .. ii, "info", { "title", "cycle_colorschemes" })
      next_scheme = cschemes[ii]

      break
    end
  end

  vim.cmd("colorscheme " .. next_scheme)
  vim.notify("Colorscheme " .. next_scheme, "info", { "title", "Cycle Colorschemes" })
end
map("n", "<F2>", ":Themery<CR>")
--vim.api.nvim_set_keymap("n", "F2", ":lua cycle_colorschemes()<CR>", {})

-- for mappings defined in lua
--require("custom-map")

-- Leader Group for all new/toggle window plugins
which = require("which-key")
which.register({
  ["<leader>n"] = { name = "+New Open" },
})

-- Gitsigns / Git Hunk Navigation
 which.register({
  ["<leader>gh"] = { name = "+Git Hunk Nav/Process" },
})

-- Minimap
codewindow = require("codewindow")
map("n", "<leader>nm", function()
  codewindow.toggle_minimap()
end, { expr = true, desc = "Minimap Toggle" })

-- ToggleTerm mappings
which.register({
  ["<leader>.nF"] = { name = "+Toggle Terminal" },
})
toggleterm = require("toggleterm")
map("n", "<leader>nf", function()
  toggleterm.toggle(vim.v.count1)
end, { desc = "Toggle default float term" })
map("n", "<leader>nFv", function()
  toggleterm.toggle(vim.v.count1, 80, "vertical", "vertical")
end, { noremap = true, silent = true, desc = "Create Vertical terminal" })
map("n", "<leader>nFh", function()
  toggleterm.toggle(vim.v.count1, 25, "horizontal", "horizontal")
end, { noremap = true, silent = true, desc = "Create Horizontal terminal" })

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
    width = function(term)
      return math.floor(vim.o.columns * 0.9)
    end,
    height = function(term)
      return math.floor(vim.o.lines * 0.9)
    end,
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,

  display_name = "Bruce Git",
})

function _lazygit_toggle()
  lazygit:toggle()
end
map("n", "<leader>ng", function()
  _lazygit_toggle()
end, { noremap = true, silent = true, desc = "Create lazygit terminal" })

-- Tags
map("n", "<leader>nv", "<cmd>Vista!!<CR>", { desc = "Toggle Vista Tagbar" })
map("n", "<F3>", "<cmd>Vista!!<CR>", { desc = "Toggle Vista Tagbar" })
