vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

vim.opt.encoding = "utf-8"

-- change fillchars for folding, vertical split, end of buffer, and message separator
vim.opt.fillchars = "fold: ,vert:│,eob: ,msgsep:‾"

-- vim.cmd("source ~/dotrepo/Nvim/lua/config/options.vim")

-- Paste mode toggle, it seems that Nvim's bracketed paste mode
-- does not work very well for nvim-qt, so we use good-old paste mode
vim.opt.pastetoggle = "<F12>"

-- Split window below/right when creating horizontal/vertical windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Time in milliseconds to wait for a mapped sequence to complete,
-- see https://unix.stackexchange.com/q/36882/221410 for more info
vim.opt.timeoutlen = 500
vim.opt.updatetime = 500 -- For CursorHold events

-- Clipboard settings, always use clipboard for all delete, yank, change, put
-- operation, see https://stackoverflow.com/q/30691466/6064933
--if vim.opt.provider.clipboard.Executable then
vim.opt.clipboard:append("unnamedplus")
--end

-- Disable creating swapfiles, see https://stackoverflow.com/q/821902/6064933
vim.opt.swapfile = false

-- Ignore certain files and folders when globing
vim.opt.wildignore:append("*.o,*.obj,*.dylib,*.bin,*.dll,*.exe")
vim.opt.wildignore:append("*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**")
vim.opt.wildignore:append("*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico")
vim.opt.wildignore:append("*.pyc,*.pkl")
vim.opt.wildignore:append("*.DS_Store")
vim.opt.wildignore:append("*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv")
vim.opt.wildignorecase = true -- ignore file and dir name cases in cmd-completion

-- Set up backup directory
vim.g.backupdir = vim.fn.stdpath("data") .. "/backup//"
vim.opt.backupdir = vim.fn.stdpath("data") .. "/backup//"
--let &backupdir=g:backupdir

-- Skip backup for patterns in option wildignore
vim.g.backupskip = vim.g.wildignore
vim.opt.backup = true -- create backup for files
vim.opt.backupcopy = "yes" -- copy the original file to backupdir and overwrite it

-- General tab settings
vim.opt.tabstop = 4 -- number of visual spaces per TAB
vim.opt.softtabstop = 4 -- number of spaces in tab when editing
vim.opt.shiftwidth = 4 -- number of spaces to use for autoindent
vim.opt.expandtab = true -- expand tab to spaces so that tabs are spaces

-- Set matching pairs of characters and highlight matching brackets
vim.opt.matchpairs:append("<:>,「:」,『:』,【:】,“:”,‘:’,《:》")

-- Show line number and relative line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Ignore case in general, but become case-sensitive when uppercase is present
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- File and script encoding settings for vim
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"

-- Break line at predefined characters
vim.opt.linebreak = true
-- Character to show before the lines that have been soft-wrapped
vim.opt.showbreak = "↪"

-- List all matches and complete till longest common string
vim.opt.wildmode = "list:longest"

-- Minimum lines to keep above and below cursor when scrolling
vim.opt.scrolloff = 3

-- Use mouse to select and resize windows, etc.
vim.opt.mouse = "nic" -- Enable mouse in several mode
vim.opt.mousemodel = "popup" -- Set the behaviour of mouse

-- Disable showing current mode on command line since statusline plugins can show it.
vim.opt.showmode = false

vim.opt.fileformats = "unix,dos" -- Fileformats to use for new files

-- Ask for confirmation when handling unsaved or read-only files
vim.opt.confirm = true

-- Do not use visual and errorbells
vim.opt.visualbell = true
vim.opt.errorbells = false
vim.opt.history = 500 -- The number of command and search history to keep

-- Use list mode and customized listchars
vim.opt.list = true
vim.opt.listchars = "tab:▸ ,extends:❯,precedes:❮,nbsp:␣"

-- Auto-write the file based on some condition
vim.opt.autowrite = true

-- Show hostname, full path of file and last-mod time on the window title. The
-- meaning of the format str for strftime can be found in
-- http://man7.org/linux/man-pages/man3/strftime.3.html. The function to get
-- lastmod time is drawn from https://stackoverflow.com/q/8426736/6064933
vim.opt.title = true
vim.opt.titlestring = ""
--vim.opt.titlestring = utils.Get_titlestr()

-- Persistent undo even after you close a file and re-open it
vim.opt.undofile = true

-- Do not show "match xx of xx" and other messages during auto-completion
vim.opt.shortmess:append("c")

-- Do not show search match count on bottom right (seriously, I would strain my
-- neck looking at it). Using plugins like vim-anzu or nvim-hlslens is a better
-- choice, IMHO.
--vim.opt.shortmess:append("S")
vim.opt.shortmess:remove("S")

-- Disable showing intro message (:intro)
vim.opt.shortmess:append("I")

-- Completion behaviour
-- vim.opt.completeopt:append("noinsert")  -- Auto select the first completion entry
vim.opt.completeopt:append("menuone") -- Show menu even if there is only one item
vim.opt.completeopt:remove("preview") -- Disable the preview window

vim.opt.pumheight = 10 -- Maximum number of items to show in popup menu
vim.opt.pumblend = 10 -- pseudo transparency for completion menu

vim.opt.winblend = 0 -- pseudo transparency for floating window

-- Insert mode key word completion setting
vim.opt.complete:append("kspell")
vim.opt.complete:remove("w")
vim.opt.complete:remove("b")
vim.opt.complete:remove("u")
vim.opt.complete:remove("t")

vim.opt.spelllang = "en,cjk" -- Spell languages
vim.opt.spellsuggest:append("9") -- show 9 spell suggestions at most

-- Align indent to next multiple value of shiftwidth. For its meaning,
-- see http://vim.1045645.n5.nabble.com/shiftround-option-td5712100.html
vim.opt.shiftround = true

-- Virtual edit is useful for visual block edit
vim.opt.virtualedit = "block"
vim.opt.virtualedit = "all"

-- Correctly break multi-byte characters such as CJK,
-- see https://stackoverflow.com/q/32669814/6064933
vim.opt.formatoptions:append("mM")

-- Tilde (~) is an operator, thus must be followed by motions like `e` or `w`.
vim.opt.tildeop = true

vim.opt.synmaxcol = 200 -- Text after this column number is not highlighted
vim.opt.startofline = false

-- External program to use for grep command
if vim.fn.executable("rg") then
  vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
  vim.opt.grepformat = "%f:%l:%c:%m"
end

-- Enable true color support. Do not set this option if your terminal does not
-- support true colors! For a comprehensive list of terminals supporting true
-- colors, see https://github.com/termstandard/colors and https://gist.github.com/XVilka/8346728.
vim.opt.termguicolors = true

-- Set up cursor color and shape in various mode, ref:
-- https://github.com/neovim/neovim/wiki/FAQ#how-to-change-cursor-color-in-the-terminal
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20"

vim.opt.signcolumn = "auto:2"

-- Remove certain character from file name pattern matching
vim.opt.isfname:remove("=")
vim.opt.isfname:remove(",")

-- diff options
vim.opt.diffopt = ""
vim.opt.diffopt:append("vertical") -- show diff in vertical position
vim.opt.diffopt:append("filler") -- show filler for deleted lines
vim.opt.diffopt:append("closeoff") -- turn off diff when one file window is closed
vim.opt.diffopt:append("context:3") -- context for diff
vim.opt.diffopt:append("internal,indent-heuristic,algorithm:histogram")

-- do no wrap
vim.opt.wrap = false

-- Default fold enable
vim.opt.foldmethod = "syntax"

vim.api.nvim_set_keymap('c', '<Down>', 'v:lua.get_wildmenu_key("<right>", "<down>")', { expr = true })
vim.api.nvim_set_keymap('c', '<Up>', 'v:lua.get_wildmenu_key("<left>", "<up>")', { expr = true })
function _G.get_wildmenu_key(key_wildmenu, key_regular)
return vim.fn.wildmenumode() ~= 0 and key_wildmenu or key_regular
end
