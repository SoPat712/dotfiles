-- mains
vim.o.compatible = false
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")
--line numbers
vim.wo.number = true
vim.wo.relativenumber = true
--bullseye cursors
vim.wo.cursorline = true
vim.wo.cursorcolumn = true
--splits
vim.opt.splitright = true
--shift/tab shit
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
--search stuff
vim.o.incsearch = true
vim.o.hlsearch = true
-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
--casing stuff
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
--random stuff
vim.o.showcmd = true
vim.o.showmode = true
vim.o.history = 1000
-- commands vim
vim.o.wildmenu = true
vim.o.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"
vim.o.updatetime = 50
--gutter
vim.wo.signcolumn = "yes"
--full colors
vim.o.termguicolors = true
--bottom of page lines left
vim.wo.scrolloff = 8
--folding stuff
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
--yanking displays
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
--clipboard fixes
vim.o.clipboard = "unnamed"
