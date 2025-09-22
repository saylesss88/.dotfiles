require "nvchad.options"

-- add yours here!

local o = vim.o

o.cursorlineopt = "both" -- to enable cursorline!
o.conceallevel = 2
o.termguicolors = true
o.colorcolumn = "80"
-- o.cursorcolumn = true
o.hlsearch = true

o.cmdheight = 2 -- more space in the neovim command line for displaying messages
o.guifont = "monospace:h17" -- the font used in graphical neovim applications
o.wrap = false
--
--
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
o.clipboard = "unnamedplus"

-- Enable break indent
o.breakindent = true

-- Save undo history
o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
o.ignorecase = true
o.smartcase = true
o.filetype = "on"

-- Keep signcolumn on by default
o.signcolumn = "yes"
-- Configure how new splits should be opened
o.splitright = true
o.splitbelow = true
-- whitespace characters
o.list = true

-- Preview substitutions live, as you type!
o.inccommand = "split"
