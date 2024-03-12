local undodir = vim.fn.expand("~/.undodir")

-- Check if the undo directory exists, if not, create it
if not vim.fn.isdirectory(undodir) then
	vim.fn.mkdir(undodir, "p", 0700)
end

-- Set the undodir and enable undofile
vim.opt.undodir = undodir
vim.opt.undofile = true
