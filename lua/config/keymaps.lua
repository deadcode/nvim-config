-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

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
map("t", "<ESC>", "<C-\\><C-n>")

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

-- for mappings defined in lua
--require("custom-map")
